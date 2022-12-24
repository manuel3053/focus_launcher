import 'package:device_apps/device_apps.dart';

getAppList() async {
  List<Application> apps = await DeviceApps.getInstalledApplications(
    onlyAppsWithLaunchIntent: true,
    includeSystemApps: false,
    includeAppIcons: false,
  );
  return apps;
}
