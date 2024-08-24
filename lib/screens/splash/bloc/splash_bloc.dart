import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_management/utils/contants/shared_pref_keys.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<InitialEvent>((event, emit) async {
      var sharedPreferences = await SharedPreferences.getInstance();

      var userId = sharedPreferences.getString(SharedPrefKeys.userId);

      await Future.delayed(const Duration(seconds: 5));
      if (userId != null && userId.isNotEmpty) {
        NavigationHelper.pushReplacementNamed(RouteHelper.home);
      } else {
        NavigationHelper.pushReplacementNamed(RouteHelper.login);
      }
    });
  }
}
