import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({required Key key}):super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //inizializzazione e assegnamento data e ora
  final DateTime _dateTime = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();

  //inizializzazione e assegnamento dati batteria
  String batteryLevel = "";
  ChargingStatus chargingStatus = ChargingStatus.Discharging; //by default, it is not charging
  int count=0;

  @override
  void initState() {
    AndroidBatteryInfo? infoAndroid = AndroidBatteryInfo();
    Future.delayed(Duration.zero, () async { //there is async (await) execution inside it
      infoAndroid = await BatteryInfoPlugin().androidBatteryInfo;
      count++;
      batteryLevel = infoAndroid!.batteryLevel.toString();
      chargingStatus = infoAndroid!.chargingStatus!;
      setState(() {
        //refresh UI
      });
    });

    BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo? batteryInfo) {
      //add listener to update values if there is changes
      count++;
      infoAndroid = batteryInfo;
      batteryLevel = infoAndroid!.batteryLevel.toString();
      chargingStatus = infoAndroid!.chargingStatus!;
      setState(() {
        //refresh UI
      });
    });

    super.initState();
  }

    @override
    Widget build(BuildContext context) {
      final DateFormat df = DateFormat("dd/MM/yyyy");

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              left: 30, right: 30, top: 50, bottom: 100),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_timeOfDay.format(context)),
                      Text(df.format(_dateTime)),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("ciao: $batteryLevel %"),
                      Text(chargingStatus.toString()),
                      Text(count.toString()),
                    ],
                  ),

                ],
              ),

            ],
          ),
        ),
      );
    }
  }
