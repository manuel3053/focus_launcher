import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:intl/intl.dart';
import 'Screens/Apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(labelLarge: TextStyle(fontSize: 40))),
      home: const LauncherHomepage(),
    );
  }
}

class LauncherHomepage extends StatefulWidget {
  const LauncherHomepage({super.key});

  @override
  State<LauncherHomepage> createState() => _LauncherHomepageState();
}

class _LauncherHomepageState extends State<LauncherHomepage> {
  late List<AppLockInfo> appLockInfoList = [];

  final DateTime _dateTime = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();
  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String _phonePkgName = '';
  String _cameraPkgName = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        /*behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (value) {
          InstalledApps.startApp(_phonePkgName);
        },
        onHorizontalDragStart: (value){
          InstalledApps.startApp(_cameraPkgName);
        },*/
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_timeOfDay.format(context)}\n${dateFormat.format(_dateTime)}',
                textAlign: TextAlign.center,
              ),
              IconButton(
                iconSize: 50,
                icon: Icon(Icons.apps),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppsScreen(
                              appLockInfoList: appLockInfoList,
                            )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  init() async {
    List<AppInfo> installedApps = await InstalledApps.getInstalledApps(true, true);
    for (int i = 0; i < installedApps.length; i++) {
      String appPkgName = installedApps[i].packageName.toString();
      if(appPkgName.contains('camera')){
        _cameraPkgName = appPkgName;
      }
      if(appPkgName.contains('dialer')){
        _phonePkgName = appPkgName;
      }
      String appName = installedApps[i].name.toString();
      try{
        AppLockInfo appLockInfo = await UserPreferences.getAppLockInfo(appPkgName);
        appLockInfoList.add(appLockInfo);
      }catch(error){
        AppLockInfo appLockInfo = AppLockInfo(
          appPkgName: appPkgName,
          appName: appName,
          startAppMinuteLock: 0,
          endAppMinuteLock: 0,
          isActive: false,
        );
        UserPreferences.setAppLockInfo(appLockInfo);
        appLockInfoList.add(appLockInfo);
      }
    }
    print(appLockInfoList[0].appName);
  }
}
