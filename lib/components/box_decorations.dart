import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_colors.dart';

class BoxDecorations {
  BoxDecorations._();

  static BoxDecoration buildBoxDecoration_1(
      {double radius = 14.0,
      double borderWidth = 0,
      Color? borderColor,
      Color decColor = AppColors.lightContainer,
      double? decOpacity}) {
    return BoxDecoration(
      border: Border.all(
        width: borderWidth,
        color: borderColor ?? decColor,
      ),
      borderRadius: BorderRadius.circular(radius),
      color: decOpacity != null ? decColor.withOpacity(decOpacity) : decColor,
    );
  }

  static BoxDecoration buildBoxDecorationImage(
      {double radius = 0, required String decImage}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      image: DecorationImage(
        image: AssetImage(
          decImage,
        ),
        fit: BoxFit.fill,
      ),
    );
  }

  static BoxDecoration decorationWithShadow(
      {double? borderRadius = 12,
      double? blurRadius,
      double? spreadRadius,
      BorderRadius? radius,
      Color? borderColor,
      Color? decColor}) {
    return BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(borderRadius!),
        border: Border.all(color: borderColor ?? Colors.transparent),
        color: decColor ?? AppColors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: blurRadius ?? 2,
              spreadRadius: spreadRadius ?? 2),
        ]);
  }

  static BoxDecoration boxDecorationwithoutShadow(
      {Color? borderColor,
      Color? backgroundColor,
      double? borderRadius,
      double? borderWidth,
      BorderRadius? radius}) {
    return BoxDecoration(
      borderRadius: radius ?? BorderRadius.circular(borderRadius ?? 12),
      color: backgroundColor ?? AppColors.white,
      border: Border.all(
          width: borderWidth ?? 1, color: borderColor ?? AppColors.white),
    );
  }

  static BoxDecoration decorationwithShape(
      {Color? backgroundColor,
      BoxShape? shape,
      double? borderRadius,
      double? borderWidth = 0,
      Color? borderColor,
      BorderRadius? radius}) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.white,
      border: Border.all(
          width: borderWidth!, color: borderColor ?? AppColors.white),
      shape: shape ?? BoxShape.circle,
    );
  }

  static BoxDecoration buildBoxDecoration_2({
    double radius = 12.0,
    double? borderWidth,
    double xvalue = 0,
    double yvalue = 4,
    double blurRadius = 28,
    double spreadRadius = 0,
    double opacity = 0.05,
    double? decOpaciry,
    Color? borderColor,
    Color decColor = AppColors.white,
    Color shadowColor = const Color(0xFF660303),
  }) {
    return BoxDecoration(
      border:
          Border.all(color: borderColor ?? decColor, width: borderWidth ?? 0),
      borderRadius: BorderRadius.circular(radius),
      color: decOpaciry != null ? decColor.withOpacity(decOpaciry) : decColor,
      boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(opacity),
          blurRadius: blurRadius,
          offset: Offset(xvalue, yvalue),
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }

  static BoxDecoration buildBoxDecoration_3(
      {double topLeft = 0,
      double topRight = 0,
      double bottomLeft = 0,
      double bottomRight = 0,
      Color? borderColor,
      double borderWidth = 1.0,
      Color decColor = AppColors.white}) {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      color: decColor,
      border: Border.all(color: borderColor ?? decColor, width: borderWidth),
    );
  }

  static BoxDecoration buildGradientBoxDecoration_1(
      {double radius = 12.0,
      Color? borderColor,
      required List<Color> decColor,
      required List<double> stops,
      Alignment begin = Alignment.topLeft,
      Alignment end = Alignment.bottomRight}) {
    return BoxDecoration(
      gradient: LinearGradient(
          //transform: GradientRotation(267),
          colors: decColor,
          begin: begin,
          end: end,
          stops: stops),
      border: Border.all(color: borderColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  static BoxDecoration buildGradientBoxDecoration_2({
    double radius = 12.0,
    Color? borderColor,
    required List<Color> decColor,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // begin: Alignment.bottomLeft,
        // end: Alignment.topRight,
        colors: decColor,
      ),
      border: Border.all(color: borderColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  // static BoxDecoration buildBoxDecoration_4(
  //     {double topLeft = 0,
  //     double topRight = 0,
  //     double bottomLeft = 0,
  //     double bottomRight = 0,
  //     double borderWidth = 1.0,
  //     double xvalue = 0,
  //     double yvalue = 4,
  //     double blurRadius = 16,
  //     double spreadRadius = 0,
  //     double opacity = 0.12,
  //     double decOpaciry = 1,
  //     Color? borderColor,
  //     Color decColor = const Color(0xFFFFFFFF),
  //     int? cond}) {
  //   return BoxDecoration(
  //     border: Border.all(color: borderColor ?? decColor, width: borderWidth),
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(topLeft),
  //       topRight: Radius.circular(topRight),
  //       bottomLeft: Radius.circular(bottomLeft),
  //       bottomRight: Radius.circular(bottomRight),
  //     ),
  //     color: decColor.withOpacity(decOpaciry),
  //     boxShadow: [
  //       BoxShadow(
  //         color: cond != null
  //             ? AppColors.shadowColorMap[cond].withOpacity(opacity)
  //             : AppColors.shadowColorMap[0].withOpacity(opacity),
  //         blurRadius: blurRadius,
  //         offset: Offset(xvalue, yvalue),
  //         spreadRadius: spreadRadius,
  //       ),
  //     ],
  //   );
  // }

  // static BoxDecoration BoxDecorationwithWhite() {
  //   return BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       color: AppColors.whiteColor().withOpacity(0.8),
  //       boxShadow: [
  //         BoxShadow(
  //             color: AppColors.whiteColor().withOpacity(0.9),
  //             blurRadius: 3,
  //             spreadRadius: 5),
  //       ]);
  // }

  // static BoxDecoration BoxDecorationwithoutShadow(
  //     {Color? borderColor,
  //     Color? backgroundColor,
  //     double? borderRadius,
  //     double? borderWidth = 1,
  //     BorderRadius? radius}) {
  //   return BoxDecoration(
  //     borderRadius: radius ?? BorderRadius.circular(borderRadius ?? 12),
  //     color: backgroundColor ?? AppColors.whiteColor(),
  //     border: Border.all(
  //         width: borderWidth!,
  //         color: borderColor ?? AppColors.borderGreyColor()),
  //   );
  // }
}
