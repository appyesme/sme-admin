import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPref;

const _token = "token";

class PrefService {
  static Future<bool> clear() => sharedPref.clear();

  static Future<bool> setToken(String? token) async {
    if (token == null) return sharedPref.remove(_token);
    return sharedPref.setString(_token, token);
  }

  static String? getToken() => sharedPref.getString(_token);
}
