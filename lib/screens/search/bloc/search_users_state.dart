part of 'search_users_bloc.dart';

@immutable
sealed class SearchUsersState {}

final class SearchUsersInitial extends SearchUsersState {}

class UsersLoadingState extends SearchUsersState {}

class FetchUsersState extends SearchUsersState {
  final List<ApiResponse> usersList;

  FetchUsersState({required this.usersList});
}

class UsersLoaded extends SearchUsersState {}

class ErrorState extends SearchUsersState {
  final String message;

  ErrorState({required this.message});
}
