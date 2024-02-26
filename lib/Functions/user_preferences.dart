import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static clearUserPreferences() => _preferences?.clear();

  static Future setAppLockInfo(String appPkgName, String appName) async {
    await _preferences!.setString(appPkgName, appName);
  }

  static Future getAppLockInfo(String appPkgName) async {
    return AppLockInfo(
        appName: _preferences!.getString(appPkgName).toString(),
        appPkgName: appPkgName,
        isVisible: true);
  }

  static Future<List<AppLockInfo>> getAppLockInfoList() async {
    final keys = _preferences?.getKeys();
    final List<AppLockInfo> appLockInfoList = List.empty(growable: true);
    for (String key in keys!) {
      print('ciao');
      appLockInfoList.add(AppLockInfo(
          appName: _preferences!.getString(key).toString(),
          appPkgName: key,
          isVisible: true));
    }
    print(appLockInfoList);
    return appLockInfoList;
  }
}
