import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();
  // appPkgName = key   value = nome 0/1 orario_inizio orario_fine
  static Future setData(String appPkgName, List<String> values) async => await _preferences!.setStringList(appPkgName, values);
  static List<String>? getData(String appPkgName) => _preferences!.getStringList(appPkgName);
  static Future setBattery(String battery) async => await _preferences!.setString('percentuale',battery);
  static String? getBattery() => _preferences!.getString('percentuale');
}