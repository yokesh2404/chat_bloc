part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetAllUsersEvent extends HomeEvent {
  final String searchtext;

  GetAllUsersEvent({required this.searchtext});
}
