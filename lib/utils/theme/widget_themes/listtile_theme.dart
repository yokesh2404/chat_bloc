import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';

class AppListTileTheme {
  AppListTileTheme._();

  static const lightTileTheme = ListTileThemeData(
    iconColor: AppColors.primaryColor,
    selectedTileColor: AppColors.grey,
    selectedColor: AppColors.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  );

  static const darkTileTheme = ListTileThemeData(
    iconColor: AppColors.primaryColor,
    selectedColor: AppColors.secondary,
    selectedTileColor: AppColors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  );
}
