import 'dart:io';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:path_provider/path_provider.dart';
// appName*appPkgName
class AppsStorage{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/apps.txt');
  }

  writeInstalledAppsToFile() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    deleteFileContent();
    for (AppInfo app in installedApps) {
      await writeAppToFile(app.name, app.packageName);
    }
  }

  Future<List<AppLockInfo>> readAppsListFromFile() async {
    List<AppLockInfo> apps = [];
    try {
      final file = await _localFile;
      final contents = await file.readAsLines();

      for(String line in contents){
        final splitLine = line.split('*');
        apps.add(AppLockInfo(appName: splitLine[0], appPkgName: splitLine[1], isVisible: true));
      }
      return apps;
    } catch (e){
      return apps;
    }
  }

  writeAppToFile(String appName, String appPkgName) async {
    final file = await _localFile;
    return file.writeAsString('$appName*$appPkgName\n', mode: FileMode.append);
  }

  deleteFileContent() async {
    final file = await _localFile;
    return file.writeAsString('');
  }

}