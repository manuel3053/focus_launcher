class AppLockInfo {
  String appPkgName;
  String appName;
  bool isVisible;

  AppLockInfo({
    required this.appName,
    required this.appPkgName,
    required this.isVisible,
  });

}

class AppLockInfoManager {
  static AppLockInfo generateDefault(String appName, String appPkgName) {
    return AppLockInfo(
        appName: appName,
        appPkgName: appPkgName,
        isVisible: true,
    );
  }
}
