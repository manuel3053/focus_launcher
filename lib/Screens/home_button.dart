import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:provider/provider.dart';
import '../Functions/user_preferences.dart';
import '../Provider/app_provider.dart';
import 'apps.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppsScreen(),
            ));
      },
      child: const Icon(
        Icons.apps,
        size: 50,
      ),
      onLongPress: () async {
        //Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
        generateAppLockInfoList();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Completed"),
        ));
      },
    );
  }

  generateAppLockInfoList() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    UserPreferences.clearUserPreferences();
    for (AppInfo app in installedApps) {
      String appPkgName = app.packageName;
      String appName = app.name;
      UserPreferences.setAppLockInfo(appPkgName, appName);
    }
  }

}