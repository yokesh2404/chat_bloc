import 'package:state_management/screens/register/model/user_details_model.dart';

class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final int timeSent;
  final String lastMessage;
  final UserProfile? userProfile;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
    this.userProfile,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['profilePic'] = profilePic;
    data['contactId'] = contactId;
    data['timeSent'] = timeSent;
    data['lastMessage'] = lastMessage;
    if (userProfile != null) {
      data['userProfile'] = userProfile!.toJson();
    }
    return data;
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: map['timeSent'] ?? 0,
      lastMessage: map['lastMessage'] ?? '',
      userProfile: map['userProfile'] != null
          ? new UserProfile.fromJson(map['userProfile'])
          : null,
    );
  }
}
