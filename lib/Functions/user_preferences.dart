import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyDisplayName = 'displayName';
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setDisplayName(String displayName) async => await _preferences!.setString(_keyDisplayName, displayName);
  static String? getDisplayName() => _preferences!.getString(_keyDisplayName);
}