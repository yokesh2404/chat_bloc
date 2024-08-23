import 'package:flutter/material.dart';
import 'package:state_management/utils/contants/app_sizes.dart';

import '../../contants/app_colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.primaryColor,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.textWhite, size: AppSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: AppColors.textWhite, size: AppSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.dark,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.white, size: AppSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: AppColors.white, size: AppSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.white),
  );
}
