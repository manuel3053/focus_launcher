import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:intl/intl.dart';
import 'Screens/Apps.dart';
import 'Screens/Home.dart';

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
      /*theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark,),*/
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  /*Set<Application> appsSetFiltered = {};
  Set<Application> appsSet = {};*/
  late List<bool> toggleList;
  late List<AppInfo> installedApps = [];
  late List<String> installedAppsName = [];
  String? prova;
  //inizializzazione e assegnamento data e ora
  final DateTime _dateTime = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();

  //batteria
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  int _batteryLevel=0;

  @override
  void initState() {

    init();
    super.initState();
  }

  init() async {
    installedApps = await InstalledApps.getInstalledApps(true, true);
    for(int i=0; i<installedApps.length; i++){
      installedAppsName.add(installedApps[i].packageName.toString());
    }
    toggleList = List.generate(installedApps.length, (index) => false, growable: true);
    _battery.batteryState.then(_updateBatteryState);
    _battery.batteryLevel.then(_updateBatteryPercentage);

    print(prova);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  void _updateBatteryPercentage(int level){
    _batteryLevel = level;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_timeOfDay.format(context)),
                  Text(df.format(_dateTime)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("$_batteryState"),
                  Text("$_batteryLevel %"),
                ],
              ),
            ],
          ),
          IconButton(
            iconSize: 50,
            icon: Icon(Icons.apps),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Apps(appList: installedAppsName,)),
              );
            },
          ),
          Text('eccomi')
        ],
      ),
    );
  }
}
