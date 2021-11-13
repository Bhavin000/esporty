import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  static final _prefs = SharedPreferences.getInstance();

  Future<bool> setData(String key, String value) async {
    final pref = await _prefs;
    return await pref.setString(key, value);
  }

  Future<String> getData(String key) async {
    final pref = await _prefs;
    return pref.getString(key) ?? '';
  }

  Future<bool> containsKey(String key) async {
    final pref = await _prefs;
    return pref.containsKey(key);
  }
}
