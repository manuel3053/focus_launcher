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
          textTheme: const TextTheme(labelLarge: TextStyle(fontSize: 40))),
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
        onHorizontalDragUpdate: (dragUpdateDetails){
          if(dragUpdateDetails.delta.dx>0){
            InstalledApps.startApp(_phonePkgName);
          }
          else{
            InstalledApps.startApp(_cameraPkgName);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Text(DateFormat('MM/dd/yyyy\nhh:mm:ss').format(DateTime.now()),textScaleFactor: 3, textAlign: TextAlign.center,);
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppsScreen(
                          appLockInfoList: appLockInfoList,
                        )),
                  );
                },
                onLongPress: () {
                  appLockInfoList.clear();
                  init();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Completed"),
                  ));
                },
                child: const Icon(Icons.apps, size: 50,),
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
      AppLockInfo appLockInfo = await UserPreferences.getAppLockInfo(appPkgName);
      if(appLockInfo.appName!='null'){
        appLockInfoList.add(appLockInfo);
      }
      else{
        appLockInfo = AppLockInfo(
          appPkgName: appPkgName,
          appName: appName,
          startAppMinuteLock: 0,
          endAppMinuteLock: 0,
          isActive: false,
        );
        appLockInfoList.add(appLockInfo);
      }
    }
  }
}
