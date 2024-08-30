import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management/di.dart';
import 'package:state_management/screens/chat/model/chat_contact.dart';
import 'package:state_management/screens/chat/model/message_model.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/utils/contants/app_enums.dart';
import 'package:state_management/utils/contants/shared_pref_keys.dart';
import 'package:state_management/utils/helper/shared_pref_controller.dart';
import 'package:state_management/utils/helper/tost_helper.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService {
  FirebaseStorageService._privateConstrustor();

  static FirebaseStorageService getInstance =
      FirebaseStorageService._privateConstrustor();

  factory FirebaseStorageService() {
    return getInstance;
  }
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userCollection = 'Users';

  Stream<List<Message>> getChatStream(String recieverUserId) async* {
    var userId = await DependencyInjection()
        .getIt<SharedPrefController>()
        .getStringData(key: SharedPrefKeys.userId);
    yield* _firestore
        .collection(_userCollection)
        .doc(userId)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      print(event);
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  Future<void> storeUserDetails(
      {required User userData, required Map request}) async {
    try {
      await _firestore
          .collection(_userCollection)
          .doc(userData.uid)
          .set({...request});
    } catch (e) {
      showToast(message: e.toString());
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>? searchUser(
      String name) async {
    try {
      var data = await _firestore
          .collection(_userCollection)
          .where("name", isEqualTo: name)
          .get();
      return data.docs;
    } catch (e) {
      showToast(message: e.toString());
    }
    return null;
  }

  Future<UserProfile?>? getUser(String userId) async {
    try {
      var data = await _firestore.collection(_userCollection).doc(userId).get();
      return UserProfile.fromJson(data.data()!);
    } catch (e) {
      showToast(message: e.toString());
    }

    return null;
  }

  // Future<List<UserProfile>> getAllUser() async {
  //   var userId = await DependencyInjection()
  //       .getIt<SharedPrefController>()
  //       .getStringData(key: SharedPrefKeys.userId);
  //   var data = await _firestore
  //       .collection(_userCollection)
  //       .where("userId", isNotEqualTo: userId)
  //       .get();

  //   List<UserProfile> users = [];

  //   for (var element in data.docs) {
  //     var user = element.data();

  //     users.add(UserProfile.fromJson(user));
  //   }

  //   return users;
  // }

  Stream<List<UserProfile>> getAllUserStream() async* {
    var userId = await DependencyInjection()
        .getIt<SharedPrefController>()
        .getStringData(key: SharedPrefKeys.userId);

    yield* _firestore
        .collection(_userCollection)
        .where("userId", isNotEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              log(jsonEncode(doc.data()));
              return UserProfile.fromJson(doc.data());
            }).toList());
  }

  Stream<List<ChatContact>> getAllChatUserStream() async* {
    try {
      var userId = await DependencyInjection()
          .getIt<SharedPrefController>()
          .getStringData(key: SharedPrefKeys.userId);

      if (userId == null) {
        // Handle case where userId is null
        yield [];
        return;
      }

      yield* _firestore
          .collection(_userCollection)
          .doc(userId)
          .collection('chats')
          .snapshots()
          .asyncMap((event) async {
        List<ChatContact> contacts = [];
        // Use Future.wait to perform operations in parallel
        var userDetailsFutures = event.docs.map((document) async {
          var chatContact = ChatContact.fromMap(document.data());
          var userData = await _firestore
              .collection(_userCollection)
              .doc(document.id)
              .get();

          if (userData.exists && userData.data() != null) {
            var user = UserProfile.fromJson(userData.data()!);
            return ChatContact(
              name: user.name ?? "",
              profilePic: user.profile ?? "",
              contactId: chatContact.contactId,
              timeSent: chatContact.timeSent,
              lastMessage: chatContact.lastMessage,
              userProfile: user,
            );
          } else {
            return null; // Or handle user not found
          }
        }).toList();

        // Wait for all user details to be fetched
        var resolvedContacts = await Future.wait(userDetailsFutures);
        contacts.addAll(resolvedContacts.whereType<ChatContact>());
        contacts.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(b.timeSent)
            .compareTo(DateTime.fromMillisecondsSinceEpoch(a.timeSent)));
        return contacts;
      });
    } catch (e) {
      // Log or handle exceptions
      print("Error fetching chat contacts: $e");
      yield []; // Emit an empty list on error
    }
  }

  _saveDataToContactsSubcollection(
    UserProfile senderUserData,
    UserProfile recieverUserData,
    String text,
    int timeSent,
    String recieverUserId,
    bool isGroupChat,
  ) async {
    try {
      if (isGroupChat) {
        await _firestore.collection('groups').doc(recieverUserId).update({
          'lastMessage': text,
          'timeSent': DateTime.now().millisecondsSinceEpoch,
        });
      } else {
// users -> reciever user id => chats -> current user id -> set data
        var recieverChatContact = ChatContact(
            name: recieverUserData.name ?? "",
            profilePic: recieverUserData.profile ?? "",
            contactId: recieverUserData.userId ?? "",
            timeSent: timeSent,
            lastMessage: text,
            userProfile: recieverUserData);

        await _firestore
            .collection(_userCollection)
            .doc(recieverUserId)
            .collection('chats')
            .doc(senderUserData.userId ?? "")
            .set(
              recieverChatContact.toMap(),
            );
        // users -> current user id  => chats -> reciever user id -> set data
        var senderChatContact = ChatContact(
            name: senderUserData.name ?? "",
            profilePic: senderUserData.profile ?? "",
            contactId: senderUserData.userId ?? "",
            timeSent: timeSent,
            lastMessage: text,
            userProfile: senderUserData);
        await _firestore
            .collection(_userCollection)
            .doc(senderUserData.userId ?? "")
            .collection('chats')
            .doc(recieverUserId)
            .set(
              senderChatContact.toMap(),
            );
      }
    } catch (e) {
      print(e);
    }
  }

  _saveMessageToMessageSubcollection({
    required String recieverUserId,
    required String senderUserId,
    required String text,
    required int timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    // required MessageReply? messageReply,
    required String senderUsername,
    required String? recieverUserName,
    required bool isGroupChat,
  }) async {
    final message = Message(
      senderId: senderUserId,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    if (isGroupChat) {
      // groups -> group id -> chat -> message
      await _firestore
          .collection('groups')
          .doc(recieverUserId)
          .collection('chats')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    } else {
      // users -> sender id -> reciever id -> messages -> message id -> store message
      await _firestore
          .collection(_userCollection)
          .doc(senderUserId)
          .collection('chats')
          .doc(recieverUserId)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
      // users -> eciever id  -> sender id -> messages -> message id -> store message
      await _firestore
          .collection(_userCollection)
          .doc(recieverUserId)
          .collection('chats')
          .doc(senderUserId)
          .collection('messages')
          .doc(messageId)
          .set(
            message.toMap(),
          );
    }
  }

  void sendTextMessage({
    required String text,
    required String recieverUserId,
    required UserProfile senderUser,
    required UserProfile receiverDetails,
    // required MessageReply? messageReply,
    required bool isGroupChat,
  }) async {
    try {
      var timeSent = DateTime.now().millisecondsSinceEpoch;

      // if (!isGroupChat) {
      //   var userDataMap =
      //       await _firestore.collection(_userCollection).doc(recieverUserId).get();
      //   recieverUserData = UserProfile.fromJson(userDataMap.data());
      // }

      var messageId = const Uuid().v1();
      print(receiverDetails);
      _saveDataToContactsSubcollection(
        senderUser,
        receiverDetails,
        text,
        timeSent,
        recieverUserId,
        false,
      );

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        username: senderUser.name ?? "",
        senderUserId: senderUser.userId ?? "",
        // messageReply: messageReply,
        recieverUserName: receiverDetails.name ?? "",
        senderUsername: senderUser.name ?? "",
        isGroupChat: isGroupChat,
      );
    } catch (e) {
      print(e.toString());
      // showSnackBar(context: context, content: e.toString());
    }
  }
}
