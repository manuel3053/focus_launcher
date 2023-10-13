class AppLockInfo {
  String appPkgName;
  String appName;
  int startAppMinuteLock;
  int endAppMinuteLock;
  bool isActive;

  AppLockInfo(
      {required this.appName,
      required this.appPkgName,
      required this.startAppMinuteLock,
      required this.endAppMinuteLock,
      required this.isActive});
}
