import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  static double screenHeight = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.first)
      .size
      .height;
  static double screenWidth = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.first)
      .size
      .width;
  static const double defaultWidth = 375;
  static const double defaultHeight = 812;

  static getHeight(double size) => (screenHeight / defaultHeight) * size;
  static getWidth(double size) => (screenWidth / defaultWidth) * size;
  static getTextSize(double size, {double? factor = 0.5}) =>
      size + (getWidth(size) - size) * factor;

  // Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double smd = 12.0;
  static const double md = 16.0;
  static const double xmd = 18.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconSmd = 18.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconHomeMenu = iconMd * 2;

  // Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXLg = 20.0;

  // Button sizes
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

  // Image sizes
  static const double imageThumbSize = 80.0;

  // Default spacing between sections
  static const double defaultSpace = 18.0;
  static const double spaceBtwItems = 16.0;
  static const double spaceBtwSections = 32.0;

  // Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusHomeCard = 5.0;

  // Input field
  static const double inputFieldRadius = borderRadiusSm;
  static const double spaceBtwInputFields = 16.0;

  // Card sizes
  static const double cardRadiusLg = 16.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;

  // Loading indicator size
  //static const double loadingIndicatorSize = 36.0;

  // Grid view spacing
  //static const double gridViewSpacing = 16.0;

// Height
  static const double dividerHeight = 1.0;
  static const double appBarHeight = 56.0;
  static const double masterCardButtonHeight = 36.0;

  static const double height_6 = 6;
  static const double height_12 = 12;
  static const double height_16 = 16;
  static const double height_24 = 24;
  static const double height_36 = 36;
  static const double height_48 = 48;
  static const double height_150 = 150;

  //Dimensions added by Yokesh

  static double height_30 = getHeight(30);
  static double height_5 = getHeight(5);
  static double height_40 = getHeight(40);
  static double height_60 = getHeight(60);
  static double height_70 = getHeight(70);
  static double height_75 = getHeight(75);
  static double height_80 = getHeight(80);
  static double height_90 = getHeight(90);
  static double height_100 = getHeight(100);
  static double height_120 = getHeight(120);
  static double height_200 = getHeight(200);
  static double height_220 = getHeight(220);
  static double height_230 = getHeight(230);
  static double height_250 = getHeight(250);
  static double height_300 = getHeight(300);
  static double height_320 = getHeight(320);
  static double height_450 = getHeight(450);
  static double width_12 = getWidth(12);
  static double width_16 = getWidth(16);
  static double width_30 = getWidth(30);
  static double width_40 = getWidth(40);
  static double width_48 = getWidth(48);
  static double width_60 = getWidth(60);
  static double width_80 = getWidth(80);
  static double width_90 = getWidth(90);
  static double width_120 = getWidth(120);

  static double width_100 = getWidth(100);
  static double width_160 = getWidth(160);
  static double width_180 = getWidth(180);
  static double width_230 = getWidth(230);
  static double width_280 = getWidth(280);
// ------------------------------------------------
  static const double width_04 = 4;
  static const double width_06 = 6;

  static const double width_24 = 24;
  static const double width_96 = 96;

  static const double size_04 = 4;

  static const double size_06 = 6;
  static const double size_08 = 8;
  static const double size_10 = 10;
  static const double size_12 = 12;
  static const double size_14 = 14;
  static const double size_16 = 16;
  static const double size_18 = 18;
  static const double size_20 = 20;
  static const double size_22 = 22;
  static const double size_24 = 24;
  static const double size_26 = 26;
  static const double size_48 = 48;

  static const double size_56 = 56;

  static const double size_100 = 100;
}
