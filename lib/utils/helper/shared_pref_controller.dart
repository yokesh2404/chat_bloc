import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  SharedPrefController(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  setStringData({required String key, dynamic data}) async {
    await sharedPreferences.setString(key, data);
  }

  getStringData({required String key}) async {
    var string = await sharedPreferences.getString(key);

    return string;
  }
}
