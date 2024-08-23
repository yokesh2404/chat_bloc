import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';

class AppCardTheme {
  AppCardTheme._();

  static const cardLightTheme = CardTheme(color: AppColors.lightContainer);

  static CardTheme cardDarkTheme = const CardTheme(color: AppColors.dark);
}
