import 'package:flutter/services.dart';
import 'package:focus_launcher/Data/app_repository.dart';
import 'package:focus_launcher/Utils/result.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppRepositoryLocal implements AppRepository {
  final _apps = <AppInfo>{};

  @override
  Future<Result<void>> loadApps() async {
    List<AppInfo> tmp = await InstalledApps.getInstalledApps(true, false);
    tmp.add(
      AppInfo(
        name: "Google Play Store",
        icon: null,
        packageName: "com.android.vending",
        versionName: "0.0.0",
        versionCode: 0,
        builtWith: BuiltWith.native_or_others,
        installedTimestamp: 0,
      ),
    );
    _apps.clear();
    _apps.addAll(tmp);
    return Result.ok(null);
  }

  @override
  Set<AppInfo> getAppsByName(String filter) {
    return _apps
        .where((AppInfo app) => app.name.toLowerCase().contains(filter))
        .toSet();
  }

  // @override
  // Future<Result<List<AppInfo>>> getAppsList() async {
  //   return Result.ok(
  //     List.filled(
  //       10,
  //       AppInfo(
  //         name: "a",
  //         icon: Uint8List(10),
  //         packageName: "c",
  //         versionName: "0.0.0",
  //         versionCode: 10,
  //         builtWith: BuiltWith.flutter,
  //         installedTimestamp: 10,
  //       ),
  //     ),
  //   );
  // }
}
