import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:focus_launcher/Services/alphabet_scroll_page.dart';

class Apps extends StatefulWidget {
  const Apps({required Key key}):super(key: key);
  @override
  State<Apps> createState() => _AppsState();
}
class _AppsState extends State<Apps> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          includeAppIcons: false,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: false),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          else {
            List<Application> apps = data.data!;
            List<String> appsName = [];

            for (var app in apps) {
              if(!app.systemApp) {
                appsName.add(app.appName);
              }
            }

            return Scaffold(
              body: AlphabetScrollPage(
                items: appsName,
                key: UniqueKey(),
                onClickedItem: (String value) {},
              ),
            );

          }
        }
      );
    }
}
