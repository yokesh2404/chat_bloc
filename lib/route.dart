import 'package:flutter/material.dart';
import 'package:state_management/screens/chat/view/chat_screen.dart';
import 'package:state_management/screens/home/view/home_screen.dart';
import 'package:state_management/screens/login/view/log_in_screen.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/screens/register/view/register_screen.dart';
import 'package:state_management/screens/splash/view/splash_screen.dart';
import 'package:state_management/utils/helper/route_helper.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case RouteHelper.splash:
        return getRoute(widget: const SplashScreen());
      case RouteHelper.login:
        return getRoute(widget: const LogInScreen());

      case RouteHelper.register:
        return getRoute(widget: const RegisterScreen());
      case RouteHelper.home:
        return getRoute(widget: const HomeScreen());
      case RouteHelper.chat:
        return getRoute(
            widget: ChatScreen(
          userProfile: settings.arguments as UserProfile,
        ));

      /// An invalid route. User shouldn't see this,
      /// it's for debugging purpose only.
      default:
        return getRoute(widget: const HomeScreen());
    }
  }
}
