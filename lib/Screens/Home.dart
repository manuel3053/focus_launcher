import 'Apps.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:battery_plus/battery_plus.dart';

class Home extends StatefulWidget {
  const Home({required Key key}):super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //inizializzazione e assegnamento data e ora
  final DateTime _dateTime = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();
  Set<Application> homeApps = {};


  //batteria
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  int _batteryLevel=0;

  @override
  void initState() {
    super.initState();
    _battery.batteryState.then(_updateBatteryState);
    _battery.batteryLevel.then(_updateBatteryPercentage);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  void _updateBatteryPercentage(int level){
    _batteryLevel = level;
  }

    @override
    Widget build(BuildContext context) {
      final DateFormat df = DateFormat("dd/MM/yyyy");

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              left: 30, right: 30, top: 50, bottom: 50),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

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
                          //Text("$_batteryState"),
                          Text("tmp"),
                          Text("$_batteryLevel %"),
                        ],
                      ),
                ],
              ),

              Column(
                /*children: <Widget>[
                  ListView.builder(itemBuilder: itemBuilder)
                ],*/
              )

            ],
          ),
        ),

      );
    }
  }
