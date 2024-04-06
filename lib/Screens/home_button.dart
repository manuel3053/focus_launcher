

import 'package:flutter/material.dart';
import 'package:focus_launcher/Functions/storage.dart';
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
              builder: (context) => AppsScreen(storage: AppsStorage(),),
            ));
      },
      child: const Icon(
        Icons.apps,
        size: 50,
      ),
      onLongPress: () async {
        //Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
        //appsStorage.writeInstalledAppsToFile();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Completed"),
        ));
      },
    );
  }

  /*generateAppLockInfoList() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    //UserPreferences.clearUserPreferences();
    for (AppInfo app in installedApps) {
      String appPkgName = app.packageName;
      String appName = app.name;

      //UserPreferences.setAppLockInfo(appPkgName, appName);
    }
  }*/

}