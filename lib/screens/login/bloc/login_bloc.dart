import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:state_management/di.dart';
import 'package:state_management/repositories/firebase_repo/firebase_repo.dart';
import 'package:state_management/utils/contants/shared_pref_keys.dart';
import 'package:state_management/utils/helper/dialog_helper.dart';
import 'package:state_management/utils/helper/functions_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';
import 'package:state_management/utils/helper/shared_pref_controller.dart';
import 'package:state_management/utils/helper/tost_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isSuccess = false;
  bool isShowPassword = false;
  final FirebaseAuthService _authService;
  LoginBloc(this._authService) : super(LoginInitial()) {
    on<LoginInitialEvent>((event, emit) {});

    on<SumbitLogin>((event, emit) async {
      if (event.email.isNotEmpty &&
          FunctionsHelper.getInstance.validateEmailForm(event.email) &&
          event.password.isNotEmpty &&
          FunctionsHelper.getInstance.isStrongPassword(event.password)) {
        await _authentication(event, emit);
      } else {
        showToast(message: "Something missing !!");
      }
    });

    on<GoogleSigninEvent>((event, emit) {
      _googleSignin(event, emit);
    });

    on<ShowPasswordEvent>((event, emit) {
      isShowPassword = !isShowPassword;
      emit(ShowPassword(isShowPassword: isShowPassword));
    });

    on<NavigateToRegister>((event, emit) async {
      NavigationHelper.pushNamed(RouteHelper.register);
    });
  }

  _authentication(SumbitLogin event, Emitter emit) async {
    try {
      AppDialogs.getInstance.showLoader(event.context);
      User? user = await _authService.signInWithEmailAndPassword(
          event.email, event.password);
      AppDialogs.getInstance.dismissLoader(event.context);
      if (user != null) {
        emit(LoginSuccess());
        await DependencyInjection()
            .getIt<SharedPrefController>()
            .setStringData(key: SharedPrefKeys.userId, data: user.uid);
        NavigationHelper.pushReplacementNamed(RouteHelper.home);
      } else {
        emit(LoginError());
      }
    } catch (e) {
      emit(LoginError());
    }
  }

  _googleSignin(GoogleSigninEvent event, Emitter emit) async {
    try {
      AppDialogs.getInstance.showLoader(event.context);
      User? user = await _authService.signInWithGoogle();
      AppDialogs.getInstance.dismissLoader(event.context);
      if (user != null) {
        emit(LoginSuccess());
        await DependencyInjection()
            .getIt<SharedPrefController>()
            .setStringData(key: SharedPrefKeys.userId, data: user.uid);
        NavigationHelper.pushReplacementNamed(RouteHelper.home);
      } else {
        emit(LoginError());
      }
    } catch (e) {
      emit(LoginError());
    }
  }
}
