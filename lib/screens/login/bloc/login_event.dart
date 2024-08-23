part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class NavigateToRegister extends LoginEvent {}

class NavigateToForgotPassword extends LoginEvent {}

class ShowPasswordEvent extends LoginEvent {}

class SumbitLogin extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  SumbitLogin(this.context, {required this.email, required this.password});
}
