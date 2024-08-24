import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/screens/splash/bloc/splash_bloc.dart';
import 'package:state_management/utils/contants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return SplashBloc()..add(InitialEvent());
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Center(
              child: Image.asset(AppImages.logo),
            );
          },
        ),
      ),
    );
  }
}
