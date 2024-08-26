part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class UserFetchedState extends HomeState {
  final List<UserProfile> users;

  UserFetchedState({required this.users});
}

class UserFetchedError extends HomeState {}
