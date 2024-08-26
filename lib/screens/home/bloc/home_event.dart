part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetAllUsersEvent extends HomeEvent {
  final List<UserProfile> allUsers;

  GetAllUsersEvent(this.allUsers);
}

class NavigateToChat extends HomeEvent {
  final UserProfile userProfile;

  NavigateToChat({required this.userProfile});
}
