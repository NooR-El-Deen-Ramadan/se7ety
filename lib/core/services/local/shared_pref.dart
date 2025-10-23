import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;
  

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static setData(String key, dynamic value) async {
    if (value is String) {
      return pref.setString(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else if (value is int) {
      return pref.setInt(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is List<String>) {
      return pref.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }
}
