import 'package:flutter/cupertino.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

import '../Functions/user_preferences.dart';

//import '../Functions/user_preferences.dart';
/*
class AppLockInfoProvider with ChangeNotifier, AppLockInfoManager {
  final List<AppLockInfo> _appLockInfoList = [];

  generateAppLockInfoList() async {
    List<AppInfo> installedApps =
        await InstalledApps.getInstalledApps(true, true);
    if (_appLockInfoList.isNotEmpty) {
      _appLockInfoList.clear();
    }
    for (AppInfo app in installedApps) {
      String appPkgName = app.packageName;
      String appName = app.name;
      UserPreferences.setAppLockInfo(appPkgName, appName);
    }
  }

}
*/