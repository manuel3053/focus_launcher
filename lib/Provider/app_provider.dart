import 'package:flutter/cupertino.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../Functions/user_preferences.dart';

class AppLockInfoProvider with ChangeNotifier, AppLockInfoManager {
  final List<AppLockInfo> _appLockInfoList = [];
  //String _camera = '';
  //String _phone = '';

  loadAppLockInfoList() async {


  }

  generateAppLockInfoList() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    _appLockInfoList.clear();
    for (AppInfo app in installedApps) {
      String appPkgName = app.packageName.toString();
      /*if (appPkgName.contains('camera')) {
        _camera = appPkgName;
      }
      if (appPkgName.contains('dialer')) {
        _phone = appPkgName;
      }*/
      /*AppLockInfo appLockInfo = await UserPreferences.getAppLockInfo(appPkgName);
      //Non cancellare questo codice perché è un test per migliorare le prestazioni limitando l'uso di user rpeferences
      if (appLockInfo.appName != 'null') {
        _appLockInfoList.add(appLockInfo);
      } else {
        appLockInfo = AppLockInfoManager.generateDefault(app.name.toString(), appPkgName);
        _appLockInfoList.add(appLockInfo);
      }*/
      AppLockInfo appLockInfo = AppLockInfoManager.generateDefault(app.name.toString(), appPkgName);
      _appLockInfoList.add(appLockInfo);
    }
  }

  //String get getPhone => _phone;
  //set setPhone(String pkg) => _phone = pkg;
  //String get getCamera => _camera;
  //set setCamera(String pkg) => _camera = pkg;
  List<AppLockInfo> get appLockInfoList => _appLockInfoList;

  updateAppLock(String appPkgName, bool isActive, int startAppMinuteLock, int endAppMinuteLock) {
    int i=0;
    for (AppLockInfo appLockInfo in appLockInfoList) {
      if (appLockInfo.appPkgName == appPkgName) {
        _appLockInfoList[i].startAppMinuteLock = startAppMinuteLock;
        _appLockInfoList[i].endAppMinuteLock = endAppMinuteLock;
        _appLockInfoList[i].isLocked = isActive;
        UserPreferences.setAppLockInfo(appLockInfo);
        notifyListeners();
      }
      i++;
    }
  }



}
