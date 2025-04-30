import 'package:flutter/services.dart';
import 'package:focus_launcher/Data/app_repository.dart';
import 'package:focus_launcher/Utils/result.dart';

class AppRepositoryLocal implements AppRepository {
  final _apps = <String, String>{};
  static const platform = MethodChannel('com.example.focus_launcher/apps');

  @override
  Future<Result<void>> loadApps() async {
    try {
      final result = await platform.invokeMethod('getInstalledApps');
      _apps.clear();
      if (result != null) {
        result.forEach((key, value) => _apps[key!] = value!);
      }
      // _apps.values.forEach((String name) => print(name));
      return Result.ok(null);
    } on PlatformException catch (e) {
      e.stacktrace;
      return Result.error(e);
    }
  }

  @override
  Map<String, String> getAppsByName(String filter) {
    Map<String, String> filtered = <String, String>{};
    _apps.entries
        .where((app) => app.value.toLowerCase().contains(filter))
        .forEach((app) => filtered[app.key] = app.value);
    return filtered;
  }
}
