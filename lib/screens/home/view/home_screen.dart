import 'package:flutter/material.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        automaticallyImplyLeading: false,
        title: Text(
          "Chats",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: AppSizes.size_18,
              fontWeight: FontWeight.w600,
              color: AppColors.white),
        ),
      ),
    );
  }
}
