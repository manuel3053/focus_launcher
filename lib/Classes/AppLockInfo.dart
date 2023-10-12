import 'package:flutter/cupertino.dart';

class AppLockInfo {
  String appName;
  String appPkgName;
  String startAppTimeLock;
  String endAppTimeLock;
  bool isActive;

  AppLockInfo(
      {required this.appName,
      required this.appPkgName,
      required this.startAppTimeLock,
      required this.endAppTimeLock,
      required this.isActive});
}
