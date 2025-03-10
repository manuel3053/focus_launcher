import 'package:focus_launcher/Utils/result.dart';
import 'package:installed_apps/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Future<Result<List<AppInfo>>>> getApps(List<AppInfo> apps) async {
  //   try {
  //     final SharedPreferencesAsync sharedPreferencesAsync =
  //         SharedPreferencesAsync();
  //     for (AppInfo app in apps) {
  //       await sharedPreferencesAsync.setStringList(app.packageName, [
  //         app.name,
  //         app.versionName,
  //         app.packageName,
  //         app.versionCode.toString(),
  //         app.installedTimestamp.toString(),
  //         app.icon.toString(),
  //         app.builtWith.toString(),
  //       ]);
  //     }
  //     return Result.ok(null);
  //   } on Exception catch (e) {
  //     return Result.error(e);
  //   }
  // }

  // Future<Result<void>> saveApps(List<AppInfo> apps) async {
  //   try {
  //     final SharedPreferencesAsync sharedPreferencesAsync =
  //         SharedPreferencesAsync();
  //     for (AppInfo app in apps) {
  //       await sharedPreferencesAsync.setStringList(app.packageName, [
  //         app.name,
  //         app.versionName,
  //         app.packageName,
  //         app.versionCode.toString(),
  //         app.installedTimestamp.toString(),
  //         app.icon.toString(),
  //         app.builtWith.toString(),
  //       ]);
  //     }
  //     return Result.ok(null);
  //   } on Exception catch (e) {
  //     return Result.error(e);
  //   }
  // }
}
