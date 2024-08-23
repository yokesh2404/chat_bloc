import 'package:flutter/material.dart';

import 'package:state_management/utils/contants/app_sizes.dart';

class AppSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: AppSizes.appBarHeight,
      left: AppSizes.defaultSpace,
      bottom: AppSizes.defaultSpace,
      right: AppSizes.defaultSpace);

  static const EdgeInsetsGeometry paddingAllLarge =
      EdgeInsets.all(AppSizes.defaultSpace);
  static const EdgeInsetsGeometry paddingAllMedium =
      EdgeInsets.all(AppSizes.md);
  static const EdgeInsetsGeometry doctorCard = EdgeInsets.symmetric(
    vertical: AppSizes.defaultSpace,
  );
  static const EdgeInsetsGeometry paddAddDoctor = EdgeInsets.fromLTRB(
      AppSizes.sm, AppSizes.defaultSpace, AppSizes.sm, AppSizes.defaultSpace);

  static const EdgeInsetsGeometry inputSpacing = EdgeInsets.all(AppSizes.smd);

  static const EdgeInsetsGeometry paddAddchem = EdgeInsets.fromLTRB(
      AppSizes.sm, AppSizes.defaultSpace, AppSizes.sm, AppSizes.defaultSpace);
}
