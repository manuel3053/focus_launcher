import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const methodChannel = MethodChannel('widgets');
  late List<Widget> screenWidgets;
  // Flutter -> invia messaggi -> Android
  // Android -> invia risposta -> Flutter

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 100),
        child: Column(
          children: <Widget>[
            //ElevatedButton(onPressed: getWidgets, child: Text("ciao")),
            Text("ciao widgets")

          ],
        ),
      ),
    );
  }
/*
  Future getWidgets() async{
    final List<Widget> newWidgets = await methodChannel.invokeMethod('getWidgets');
    setState(() => screenWidgets = newWidgets);
  }*/
}
