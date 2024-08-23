part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterInitial extends RegisterEvent {}

class FormDataStoreEvent extends RegisterEvent {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final BuildContext context;

  FormDataStoreEvent(this.context,
      {required this.userName,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class ShowPasswordEvent extends RegisterEvent {}

class ShowConfirmPasswordEvent extends RegisterEvent {}

class FormSubmitEvent extends RegisterEvent {}
