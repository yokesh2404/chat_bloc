part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginSuccess extends LoginState {}

class ShowPassword extends LoginState {
  final bool isShowPassword;

  ShowPassword({required this.isShowPassword});
}

class LoginError extends LoginState {}
