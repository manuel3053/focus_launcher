import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Widgets extends StatefulWidget {
  const Widgets({required Key key}):super(key: key);
  @override
  State<Widgets> createState() => _WidgetsState();
}
/*
* Il codice successivo è stato implementato solo con scopo di testing
* e non rappresenta le reali funzionalità del widget
* */
class _WidgetsState extends State<Widgets> {
  int _counter = 0;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 100),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(_timeOfDay.format(context)),
                    Text(df.format(_dateTime)),
                  ],
                ),

              ],
            ),

            Text("ciao widgets")

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  _getAppList() async {
    List apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,
      includeAppIcons: true,
    );
    return apps;
  }

}
