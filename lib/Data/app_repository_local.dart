import 'package:flutter/services.dart';
import 'package:focus_launcher/Data/app_repository.dart';
import 'package:focus_launcher/Utils/result.dart';

class AppRepositoryLocal implements AppRepository {
  static const platform = MethodChannel('com.example.focus_launcher/apps');

  @override
  Future<Result<Map<String, String>>> loadApps() async {
    try {
      final result = await platform.invokeMethod('getInstalledApps');
      var apps = <String, String>{};
      if (result != null) {
        result.forEach((key, value) => apps[key!] = value!);
      }
      return Result.ok(apps);
    } on PlatformException catch (e) {
      e.stacktrace;
      return Result.error(e);
    }
  }
}
