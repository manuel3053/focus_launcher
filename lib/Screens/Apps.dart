import 'package:flutter/services.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apps extends StatefulWidget {
  var appsTimerInfo = {};
  Apps({super.key, required this.appsTimerInfo});
  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  late TextEditingController _searchController;
  late SharedPreferences prefs;
  late List<DropdownMenuItem> _hour = [];
  late List<DropdownMenuItem> _minute = [];
  var appsTimerInfoFiltered = {};

  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    appsTimerInfoFiltered = widget.appsTimerInfo;
    _searchController = TextEditingController();
    _hour = List.generate(
        24,
        (index) => DropdownMenuItem(
              value: index < 10 ? '0${index.toString()}' : index.toString(),
              child:
                  Text(index < 10 ? '0${index.toString()}' : index.toString()),
            ));
    _minute = List.generate(
        60,
        (index) => DropdownMenuItem(
              value: index < 10 ? '0${index.toString()}' : index.toString(),
              child:
                  Text(index < 10 ? '0${index.toString()}' : index.toString()),
            ));

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            autofocus: true,
            controller: _searchController,
            onChanged: (String value) => filtraApp(value),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search...',
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (e) =>  Navigator.pop(context),
        child: ListView.builder(
          itemCount: appsTimerInfoFiltered.length,
          itemBuilder: (context, index) {
            String appPkgName = appsTimerInfoFiltered.keys.elementAt(index).toString();
            List<String> values = UserPreferences.getData(appPkgName) ?? appsTimerInfoFiltered[appPkgName];
            String appName = values[0];
            bool isActive = values[1] == '1' ? true : false;
            return Card(
              child: ListTile(
                trailing: isActive ? Icon(Icons.access_time) : null,
                title: GestureDetector(
                  onTap: () => InstalledApps.startApp(appPkgName),
                  onLongPress: () => InstalledApps.openSettings(appPkgName),
                  onDoubleTap: () {
                    List<String> dropdownValues = [
                      values[2].substring(0, 2),
                      values[2].substring(3, 5),
                      values[3].substring(0, 2),
                      values[3].substring(3, 5)
                    ];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(8),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Discard')),
                              TextButton(
                                  onPressed: () {
                                    UserPreferences.setData(appPkgName, [
                                      appName,
                                      isActive ? '1' : '0',
                                      '${dropdownValues[0]}:${dropdownValues[1]}',
                                      '${dropdownValues[2]}:${dropdownValues[3]}'
                                    ]);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text('Save')),
                            ],
                            title: Text('Activate timer'),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Switch.adaptive(
                                        value: isActive,
                                        onChanged: (bool value) {
                                          isActive = value;
                                          List<String> valuesTmp = values;
                                          valuesTmp[1] = value ? '1' : '0';
                                          UserPreferences.setData(
                                              appPkgName, valuesTmp);
                                          setState(() {});
                                        }),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DropdownButton(
                                          items: _hour,
                                          onChanged: (v) {
                                            setState(() {
                                              dropdownValues[0] = v;
                                            });
                                          },
                                          value: dropdownValues[0],
                                        ),
                                        Text(' : '),
                                        DropdownButton(
                                          items: _minute,
                                          onChanged: (v) {
                                            setState(() {
                                              dropdownValues[1] = v;
                                            });
                                          },
                                          value: dropdownValues[1],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DropdownButton(
                                          items: _hour,
                                          onChanged: (v) {
                                            setState(() {
                                              dropdownValues[2] = v;
                                            });
                                          },
                                          value: dropdownValues[2],
                                        ),
                                        Text(' : '),
                                        DropdownButton(
                                          items: _minute,
                                          onChanged: (v) {
                                            setState(() {
                                              dropdownValues[3] = v;
                                            });
                                          },
                                          value: dropdownValues[3],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
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
      ),
    );
  }

  void filtraApp(String val) {
    appsTimerInfoFiltered = {};
    for (final key in widget.appsTimerInfo.keys) {
      List<String> values = widget.appsTimerInfo[key];
      if (values[0].toString().toLowerCase().contains(val)) {
        appsTimerInfoFiltered[key] = values;
      }
    }
    setState(() {});
  }
}
