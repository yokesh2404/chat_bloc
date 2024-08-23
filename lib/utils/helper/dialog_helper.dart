import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/widgets/custom_loader.dart';

class AppDialogs {
  AppDialogs._privateConstrustor();

  static final AppDialogs getInstance = AppDialogs._privateConstrustor();

  bool isDialogShowing = false;
  bool isShowAlert = false;

  factory AppDialogs() {
    return getInstance;
  }

  showLoader(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    isDialogShowing = true;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return const CustomLoader();
      },
    );
  }

  dismissLoader(BuildContext context) {
    if (isDialogShowing) {
      isDialogShowing = false;
      NavigationHelper.pop();
    }
  }

  openBottomSheet(
      {required Widget widget,
      required BuildContext context,
      bool dismissable = true,
      required VoidCallback onCloseSheet,
      bool isScrollControlled = true,
      Color? backgroundColor}) {
    showModalBottomSheet(
      backgroundColor: backgroundColor ?? AppColors.lightContainer,
      isScrollControlled: isScrollControlled,
      isDismissible: dismissable,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: widget,
        );
      },
    ).whenComplete(() => onCloseSheet());
  }

  showAlertDialog(BuildContext context,
      {bool barrierDismissible = false,
      EdgeInsets? insetPadding,
      required Widget child,
      double? radius,
      required VoidCallback onCloseDialog}) {
    isShowAlert = true;

    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? AppSizes.width_24),
          ),
          insetPadding: insetPadding ??
              const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          child: child,
        );
      },
    ).whenComplete(() {
      onCloseDialog();
    });
  }

  dismissAlert(BuildContext context) {
    if (isShowAlert) {
      isShowAlert = false;
      NavigationHelper.pop();
    }
  }
}
