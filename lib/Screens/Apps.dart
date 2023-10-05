import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter/material.dart';
import '../Models/appswitch.dart';
import '../Functions/time_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Apps extends StatefulWidget {
  var appsTimerInfo = {};
  Apps({super.key, required this.appsTimerInfo});
  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> with AppTime{
  late TextEditingController _searchController;
  late TextEditingController _startController;
  late TextEditingController _endController;
  late List<bool> toggleList;
  late SharedPreferences prefs;
  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    init();

    _searchController = TextEditingController();
    _startController = TextEditingController();
    _endController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _startController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  init() async {
    toggleList = List.generate(widget.appsTimerInfo.length, (index) => false, growable: true);
    //widget.appsTimerInfo.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            //onChanged: (String value) => filtraApp(value),
            //onChanged: init(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search...',
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.appsTimerInfo.length,
        itemBuilder: (context, index) {
          String appName = widget.appsTimerInfo.keys.elementAt(index).toString();
          List<String> values = widget.appsTimerInfo[appName];
          bool isActive = values[0] as bool;
          return Card(
            child: SwitchListTile(
              onChanged: (bool value) async {
                toggleList[index] = value;
                setState(() {
                  prefs.setInt(appName, value as int);
                });
              },
              value: isActive,
              //value: widget.appsTimerInfo[appName],
              title: GestureDetector(
                  onTap: () => InstalledApps.startApp(appName),
                  onLongPress: () => InstalledApps.openSettings(appName),
                  /*onDoubleTap: () async {
                    start = await openTimePicker(context);
                    end = await openTimePicker(context);
                  },*/
                onDoubleTap: (){
                  showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: Text('Discard')),
                          TextButton(onPressed: (){}, child: Text('Ok')),
                        ],
                        title: Column(
                          children: [
                            TextField(
                              controller: _startController,
                              //onChanged: (String value) => filtraApp(value),
                              //onChanged: init(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'start (h24)',
                              ),
                            ),
                            TextField(
                              controller: _endController,
                              //onChanged: (String value) => filtraApp(value),
                              //onChanged: init(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'end (h24)',
                              ),
                            ),
                          ],
                        ),
                      );
                  });
                },
                  child: Text(appName),
              ),
            ),
          );
        },
      ),
    );
  }
/*
  void filtraApp(String val,) {
    appsSetFiltered.clear();
    for(int i=0; i<appsSet.length; i++){
      if(appsSet.elementAt(i).appName.toLowerCase().contains(val)){
        appsSetFiltered.add(appsSet.elementAt(i));
      }
    }
    setState(() {});
  }*/

}
