import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setAppLockInfo(AppLockInfo appLockInfo) async {
    await _preferences!
        .setString('${appLockInfo.appPkgName} appName', appLockInfo.appName);
    await _preferences!.setInt('${appLockInfo.appPkgName} startAppMinuteLock',
        appLockInfo.startAppMinuteLock);
    await _preferences!.setInt('${appLockInfo.appPkgName} endAppMinuteLock',
        appLockInfo.endAppMinuteLock);
    await _preferences!.setInt(
        '${appLockInfo.appPkgName} isActive', appLockInfo.isActive ? 1 : 0);
  }

  static Future getAppLockInfo(String appPkgName) async {
    return AppLockInfo(
        appName: _preferences!.getString('$appPkgName appName').toString(),
        appPkgName: appPkgName,
        startAppMinuteLock:
            _preferences!.getInt('$appPkgName startAppMinuteLock') ?? 0,
        endAppMinuteLock:
            _preferences!.getInt('$appPkgName endAppMinuteLock') ?? 0,
        isActive:
            _preferences!.getInt('$appPkgName isActive') == 1 ? true : false);
  }
}
