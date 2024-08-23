import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:state_management/repositories/firebase_repo/firebase_repo.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/utils/helper/dialog_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/tost_helper.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterEvent>((event, emit) {});

    on<FormDataStoreEvent>(
      (event, emit) async {
        emit(FromsDataState(
            userName: event.userName,
            email: event.email,
            password: event.password,
            confirmPassword: event.confirmPassword));
        AppDialogs.getInstance.showLoader(event.context);
        var credential = await FirebaseAuthService()
            .signUpWithEmailAndPassword(event.email, event.confirmPassword);

        AppDialogs.getInstance.dismissLoader(event.context);
        if (credential != null) {
          Map request = {
            "name": event.userName,
            "email": event.email,
            "status": "created"
          };
          await FirebaseStorageService.getInstance
              .storeUserDetails(userData: credential, request: request);
          showToast(message: "Register Successfully");
          NavigationHelper.pop();
        }
      },
    );
    on<ShowPasswordEvent>(
      (event, emit) {
        isShowPassword = !isShowPassword;

        emit(ShowPassword(isShowPassword: isShowPassword));
      },
    );
    on<ShowConfirmPasswordEvent>(
      (event, emit) {
        isShowConfirmPassword = !isShowConfirmPassword;

        emit(ShowConfirmPassword(isShowConfirmPassword: isShowConfirmPassword));
      },
    );
  }
}
