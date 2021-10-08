import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

class PreferencesConfig {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static int? getInt(String key, [String? defValue]) {
    return _prefsInstance!.getInt(key);
  }

  static String getString(String key) {
    return _prefsInstance!.getString(key) ?? "";
  }

  static Future<bool> setInt(String key, int value) async {
    return _prefsInstance!.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return _prefsInstance!.setString(key, value);
  }

  static clearData(){
    _prefsInstance!.clear();
  }
}