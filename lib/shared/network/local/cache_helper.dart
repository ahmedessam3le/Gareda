import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setThemeMode({required bool isDark}) async {
    return await sharedPreferences!.setBool('isDark', isDark);
  }

  static bool getThemeMode() {
    return sharedPreferences!.getBool('isDark') ?? false;
  }
}
