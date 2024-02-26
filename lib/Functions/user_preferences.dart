import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static clearUserPreferences () => _preferences?.clear();

  static Future setAppLockInfo(AppLockInfo appLockInfo) async {
    await _preferences!
        .setString('${appLockInfo.appPkgName} appPkgName', appLockInfo.appName);

  }

  static Future getAppLockInfo(String appPkgName) async {
    return AppLockInfo(
        appName: _preferences!.getString('$appPkgName appPkgName').toString(),
        appPkgName: appPkgName,
  isVisible: true);
  }
}
