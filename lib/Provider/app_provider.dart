import 'package:flutter/cupertino.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../Functions/user_preferences.dart';

class AppLockInfoProvider with ChangeNotifier, AppLockInfoManager {
  final List<AppLockInfo> _appLockInfoList = [];
  String _camera = '';
  String _phone = '';

  generateAppLockInfoList() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    for (AppInfo app in installedApps) {
      String appPkgName = app.packageName.toString();
      if (appPkgName.contains('camera')) {
        _camera = appPkgName;
      }
      if (appPkgName.contains('dialer')) {
        _phone = appPkgName;
      }
      AppLockInfo appLockInfo = await UserPreferences.getAppLockInfo(appPkgName);
      if (appLockInfo.appName != 'null') {
        _appLockInfoList.add(appLockInfo);
      } else {
        appLockInfo = AppLockInfoManager.generateDefault(app.name.toString(), appPkgName);
        _appLockInfoList.add(appLockInfo);
      }
    }
  }

  String get getPhone => _phone;
  //set setPhone(String pkg) => _phone = pkg;
  String get getCamera => _camera;
  //set setCamera(String pkg) => _camera = pkg;
  List<AppLockInfo> get appLockInfoList => _appLockInfoList;

  updateAppLock(AppLockInfo appLockInfo) {
    for (AppLockInfo appLockInfoTmp in appLockInfoList) {
      if (appLockInfoTmp.appPkgName == appLockInfo.appPkgName) {
        _appLockInfoList.remove(appLockInfoTmp);
        _appLockInfoList.add(appLockInfo);
        UserPreferences.setAppLockInfo(appLockInfo);
        notifyListeners();
      }
    }
  }



}
