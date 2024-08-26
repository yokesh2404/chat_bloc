part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatInitialState extends ChatState {
  final UserProfile currentUser;

  ChatInitialState({required this.currentUser});
}

class ChatsList extends ChatState {
  final List<Message> messages;

  ChatsList({required this.messages});
}
