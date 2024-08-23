import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';

class AppDialogTheme {
  AppDialogTheme._();

  static DialogTheme dialogLightTheme = DialogTheme(
    backgroundColor: AppColors.lightContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.size_06),
    ),
  );

  static DialogTheme dialogDarkTheme = DialogTheme(
    backgroundColor: AppColors.dark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.size_06),
    ),
  );
}
