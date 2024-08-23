import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';

class AppTabBarTheme {
  AppTabBarTheme._();

  static const tabbarLightTheme = TabBarTheme(
      labelColor: AppColors.textWhite,
      indicatorColor: AppColors.secondary,
      unselectedLabelColor: AppColors.darkGrey,
      indicatorSize: TabBarIndicatorSize.tab);

  static const tabbarDarkTheme = TabBarTheme(
      labelColor: AppColors.dark,
      indicatorColor: AppColors.secondary,
      unselectedLabelColor: AppColors.darkGrey,
      indicatorSize: TabBarIndicatorSize.tab);
}
