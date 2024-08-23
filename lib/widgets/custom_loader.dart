import 'package:flutter/material.dart';
import 'package:state_management/utils/contants/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Image.asset(
          //   AppImages.loaderLogo,
          //   height: 50,
          //   width: 50,
          // ),
          const CircularProgressIndicator(
            color: AppColors.primaryColor,
            strokeWidth: 2,
            strokeAlign: 20,
          ),
        ],
      ),
    ));
  }
}
