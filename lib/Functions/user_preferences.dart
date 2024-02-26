import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();
  static clearUserPreferences () => _preferences?.clear();
  static Future setAppLockInfo(AppLockInfo appLockInfo) async {
    await _preferences!
        .setString('${appLockInfo.appPkgName} appName', appLockInfo.appName);
    await _preferences!.setInt('${appLockInfo.appPkgName} startAppMinuteLock',
        appLockInfo.startAppMinuteLock);
    await _preferences!.setInt('${appLockInfo.appPkgName} endAppMinuteLock',
        appLockInfo.endAppMinuteLock);
    await _preferences!.setInt(
        '${appLockInfo.appPkgName} isLocked', appLockInfo.isLocked ? 1 : 0);
  }

  static Future getAppLockInfo(String appPkgName) async {
    return AppLockInfo(
        appName: _preferences!.getString('$appPkgName appName').toString(),
        appPkgName: appPkgName,
        startAppMinuteLock:
            _preferences!.getInt('$appPkgName startAppMinuteLock') ?? 0,
        endAppMinuteLock:
            _preferences!.getInt('$appPkgName endAppMinuteLock') ?? 0,
        isLocked:
            _preferences!.getInt('$appPkgName isLocked') == 1 ? true : false, isVisible: true);
  }
}
