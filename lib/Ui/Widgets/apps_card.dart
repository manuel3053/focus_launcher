import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppsCard extends StatelessWidget {
  final String packageName;
  final String label;
  static const platform = MethodChannel('com.example.focus_launcher/apps');

  const AppsCard({super.key, required this.packageName, this.label = "sus"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ListTile(
        onTap: () {
          // InstalledApps.startApp(appInfo.packageName);
          platform.invokeMethod('openApp', {"packageName": packageName});
          Navigator.pop(context);
        },
        onLongPress: () {
          // InstalledApps.openSettings(appInfo.packageName);
          platform.invokeMethod('openInSettings', {"packageName": packageName});
          Navigator.pop(context);
        },
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white60, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(left: 8),
        title: Text(label),
        tileColor: Colors.black,
      ),
    );
  }
}
