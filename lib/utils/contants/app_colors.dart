import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xFF910F36);
  static const Color secondary = Color(0xffBAE162);
  static const Color accent = Color(0xFFFFEEEE);
  static const Color appBackgroundColor = Color(0xFFf5f5f5);
  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color(0xff0C1C2E);

  // Text colors
  static const Color textPrimary = Color(0xFF120101);
  static const Color textSecondary = Color(0xFF191D23);
  static const Color textPrimaryDark = Color(0xFFFEFEFE);
  static const Color textSecondaryDark = Color(0xFFFEFEFE);
  static const Color textWhite = Color(0xFFFEFEFE);
  static const Color textGrey = Colors.grey;

  // Background colors
  static const Color light = Color(0xFFFEFEFE);
  static Color lightSecondary = light.withOpacity(0.9);
  static const Color dark = Color(0xFF272727);
  static Color darkSecondary = dark.withOpacity(0.9);

  static Color lightRedColor = const Color.fromARGB(255, 222, 100, 100);

  // Background Container colors
  static const Color lightContainer = Color(0xFFFFFFFF);
  static Color darkContainer = AppColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = primaryColor;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFCCD1D6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color.fromARGB(255, 8, 50, 92);

  // Neutral Shades
  static const Color black = Color(0xFF000000);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Colors.green;
  static const Color blue = Colors.blue;
  static const Color royalBlue = Color.fromARGB(255, 13, 25, 117);
  static const Color blueShade = Color.fromRGBO(100, 181, 246, 1);
  static const Color red = Colors.red;
  static const Color CountryBackground = Color(0xffe5e5e5);
  static const Color selectedProfileBackground = Color.fromRGBO(175, 0, 97, .1);
  static const Color selectedSeatProfileContainer =
      Color.fromRGBO(80, 177, 87, 1);

  static const List<Color> defaultGradient = [
    darkBlue,
    darkerBlue,
    darkestBlue,
  ];
}
