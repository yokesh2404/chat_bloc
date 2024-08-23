import 'package:flutter/material.dart';
import 'package:state_management/components/box_decorations.dart';
import 'package:state_management/utils/contants/app_colors.dart';

import '../utils/contants/app_sizes.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.onClick,
      this.height,
      this.width,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      required this.buttonText,
      this.fontColor,
      this.decoration,
      this.textStyle,
      this.icon});

  final Function() onClick;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final String buttonText;
  final Color? fontColor;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        height: height ?? AppSizes.height_60,
        decoration: decoration ??
            BoxDecorations.boxDecorationwithoutShadow(
                backgroundColor: backgroundColor ?? AppColors.primaryColor,
                borderColor: borderColor ?? AppColors.primaryColor,
                borderRadius: borderRadius ?? AppSizes.size_100),
        width: width ?? AppSizes.screenWidth,
        alignment: Alignment.center,
        child: icon ??
            Text(
              buttonText,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14, color: fontColor ?? AppColors.light),
            ),
      ),
    );
  }
}
