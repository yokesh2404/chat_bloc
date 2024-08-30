import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_management/di.dart';
import 'package:state_management/repositories/firebase_repo/firebase_repo.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/login/bloc/login_bloc.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/utils/contants/app_enums.dart';
import 'package:state_management/utils/contants/shared_pref_keys.dart';
import 'package:state_management/utils/helper/encrypt_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';
import 'package:state_management/utils/helper/shared_pref_controller.dart';
import 'package:uuid/uuid.dart';

import '../model/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  DependencyInjection di = DependencyInjection();

  UserProfile currentUser = UserProfile();
  StreamSubscription<List<Message>>? _subscription;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // StreamSubscription? _subscription;
  ChatBloc() : super(ChatInitial()) {
    on<GetChatListEvent>((event, emit) async {});

    on<SendMessageEvent>((event, emit) async {
      var userId = await di
          .getIt<SharedPrefController>()
          .getStringData(key: SharedPrefKeys.userId);

      var userData = await di.getIt<FirebaseStorageService>().getUser(userId);
      print(event.receiverDetails);
      currentUser = userData!;
      di.getIt<FirebaseStorageService>().sendTextMessage(
          text: EncryptHelper.encryptAES(event.message),
          recieverUserId: event.receiverDetails.userId ?? "",
          senderUser: userData,
          receiverDetails: event.receiverDetails,
          isGroupChat: false);
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();

    return super.close();
  }
}
