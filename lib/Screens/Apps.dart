import 'dart:ffi';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_launcher/Services/alphabet_scroll_page.dart';

class Apps extends StatefulWidget {
  const Apps({required Key key}):super(key: key);
  @override
  State<Apps> createState() => _AppsState();
}
class _AppsState extends State<Apps> {
  List<String> appsName = [];
  List<String> appsNameFiltered = [];
  int k=0;
  bool flag = true;
  String prova='';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: (String value) => filtraApp(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Application>>(
                future: DeviceApps.getInstalledApplications(
                  includeAppIcons: false,
                  includeSystemApps: true,
                  onlyAppsWithLaunchIntent: true,
                ),
                builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
                  if (data.data == null) {
                    if(kDebugMode){
                      print('non ce la faccio');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                  else {
                    List<Application> apps = data.data!;

                    if(appsName.isEmpty) {
                      for (Application app in apps) {
                        appsName.add(app.appName + ' *');
                      }
                    }

                    if(appsNameFiltered.isEmpty){
                      appsNameFiltered=appsName;
                    }

                    if(kDebugMode){
                      print('bho non capisco');
                    }

                    return Scaffold(
                      body: AlphabetScrollPage(
                        items: appsNameFiltered,
                        key: UniqueKey(),
                        onClickedItem: (String value) {},
                      ),
                    );
                  }
                }
            ),
          )
        ],
      ),
    );

  }

  void filtraApp(String val,) {
    print('ciao');
    print(appsNameFiltered.length);
    for(int i=0; i<appsName.length; i++){
      for(int j=0; j<appsName[i].length; j++){
        String nome=appsName[i].substring(0,val.length);
        print(nome+' !');
        if(nome==val){
          print('dovremmmo esserci');
          appsNameFiltered.add(appsName[i]+' UP');
        }
      }
    }
    setState(() {});
  }

}
