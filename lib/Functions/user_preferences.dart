import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyDisplayName = 'displayName';
  static Future init() async => _preferences = await SharedPreferences.getInstance();
  // appPkgName = key   value = 0/1 orario_inizio orario_fine
  static Future setData(String appPkgName, List<String> value) async => await _preferences!.setStringList(appPkgName, value);
  static List<String>? getData(String appPkgName) => _preferences!.getStringList(appPkgName);
}