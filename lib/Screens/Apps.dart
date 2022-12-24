import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:focus_launcher/Services/GetApps.dart';
import 'package:intl/intl.dart';

class Apps extends StatefulWidget {
  const Apps({required Key key}):super(key: key);
  @override
  State<Apps> createState() => _AppsState();
}
/*
* Il codice successivo è stato implementato solo con scopo di testing
* e non rappresenta le reali funzionalità del widget
* */
class _AppsState extends State<Apps> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

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

            Text("ciao apps"),


          ],
        ),
      ),
    );
  }


}
