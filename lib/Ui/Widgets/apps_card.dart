import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppsCard extends StatelessWidget {
  final AppInfo appInfo;
  const AppsCard({super.key, required this.appInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ListTile(
        onTap: () {
          InstalledApps.startApp(appInfo.packageName);
          Navigator.pop(context);
        },
        onLongPress: () {
          InstalledApps.openSettings(appInfo.packageName);
          Navigator.pop(context);
        },
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white60, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(left: 8),
        title: Text(appInfo.name),
        tileColor: Colors.black,
      ),
    );
  }
}
