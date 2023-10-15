class AppLockInfo {
  String appPkgName;
  String appName;
  int startAppMinuteLock;
  int endAppMinuteLock;
  bool isActive;
  int endLock = -1;

  AppLockInfo(
      {required this.appName,
      required this.appPkgName,
      required this.startAppMinuteLock,
      required this.endAppMinuteLock,
      required this.isActive});

  setEndLock(int minutes) => endLock=minutes;
  int getEndLock() {
    return endLock;
  }
  resetEndLock() => endLock=-1;
}
