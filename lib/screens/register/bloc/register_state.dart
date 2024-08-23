part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}

class FromsDataState extends RegisterState {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  FromsDataState(
      {required this.userName,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

class RegisterSuccess extends RegisterState {}

class RegisterLoading extends RegisterState {}

class ShowPassword extends RegisterState {
  final bool isShowPassword;

  ShowPassword({required this.isShowPassword});
}

class ShowConfirmPassword extends RegisterState {
  final bool isShowConfirmPassword;

  ShowConfirmPassword({required this.isShowConfirmPassword});
}

class RegisterFailureState extends RegisterState {}
