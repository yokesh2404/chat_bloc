part of 'search_users_bloc.dart';

@immutable
sealed class SearchUsersEvent {}

class FetchUsersEvent extends SearchUsersEvent {}
