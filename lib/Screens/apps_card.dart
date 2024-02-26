import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/app_provider.dart';
import 'apps.dart';

class AppsCard extends StatelessWidget{
  final AppLockInfo appLockInfo;
  const AppsCard({super.key, required this.appLockInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          InstalledApps.startApp(appLockInfo.appPkgName);
          Navigator.pop(context);
        },
        onLongPress: () =>
            InstalledApps.openSettings(appLockInfo.appPkgName),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(appLockInfo.appName),
            ),
          ),
        ));
  }
}