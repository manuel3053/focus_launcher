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

  setEndLock(int minutes) => endLock = minutes;
  int getEndLock() {
    return endLock;
  }

  resetEndLock() => endLock = -1;

}

class AppLockInfoManager {
  static AppLockInfo generateEmpty() {
    return AppLockInfo(
        appName: '',
        appPkgName: '',
        startAppMinuteLock: 0,
        endAppMinuteLock: 0,
        isActive: false);
  }
  static AppLockInfo generateDefault(String appName, String appPkgName) {
    return AppLockInfo(
        appName: appName,
        appPkgName: appPkgName,
        startAppMinuteLock: 0,
        endAppMinuteLock: 0,
        isActive: false);
  }
}
