part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class GetChatListEvent extends ChatEvent {
  final UserProfile receiverDetails;

  GetChatListEvent({required this.receiverDetails});
}

class SendMessageEvent extends ChatEvent {
  final UserProfile receiverDetails;
  final String message;
  final MessageEnum messageType;

  SendMessageEvent(
      {required this.receiverDetails,
      required this.message,
      required this.messageType});
}
