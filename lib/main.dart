import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
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
        textTheme: TextTheme(
          labelLarge: TextStyle(
            fontSize: 40
          )
        )
      ),
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: const LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  late List<AppInfo> installedApps = [];
  late List<String> installedAppsName = [];
  String? prova;
  //inizializzazione e assegnamento data e ora
  final DateTime _dateTime = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();
  var appsTimerInfo = {};

  //batteria
  final Battery _battery = Battery();

  BatteryState? _batteryState;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_timeOfDay.format(context), style: Theme.of(context).textTheme.labelLarge,),
                  Text(df.format(_dateTime)),
                ],
              ),
              Text(UserPreferences.getBattery().toString()),
            ],
          ),
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.apps),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Apps(
                          appsTimerInfo: appsTimerInfo,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }

  init() async {
    installedApps = await InstalledApps.getInstalledApps(true, true);
    for (int i = 0; i < installedApps.length; i++) {
      String installedAppPkgName = installedApps[i].packageName.toString();
      String installedAppName = installedApps[i].name.toString();

      if ((UserPreferences.getData(installedAppName)) == null) {
        UserPreferences.setData(
            installedAppPkgName, [installedAppName, '0', '00:00', '00:00']);
        appsTimerInfo[installedAppPkgName] = [
          installedAppName,
          '0',
          '00:00',
          '00:00'
        ];
      } else {
        appsTimerInfo[installedAppPkgName] =
            UserPreferences.getData(installedAppName);
      }
    }
    _battery.batteryState.then(_updateBatteryState);
    _battery.batteryLevel.then(_updateBatteryPercentage);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  void _updateBatteryPercentage(int level) {
    UserPreferences.setBattery('$level%');
    setState(() {});
  }
}
