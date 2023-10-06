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
  late List<TextEditingController> _timeController = [];
  late List<FocusNode> _focusNodes = [];
  late List<bool> toggleList;
  late SharedPreferences prefs;
  var appsTimerInfoFiltered = {};
  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    init();
    appsTimerInfoFiltered = widget.appsTimerInfo;
    _timeController = List.generate(4, (index) => TextEditingController());
    _searchController = TextEditingController();
    _focusNodes = List.generate(4, (index) => FocusNode());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    for (int i = 0; i < 4; i++) {
      _timeController[i].dispose();
    }
    super.dispose();
  }

  init() async {
    toggleList = List.generate(widget.appsTimerInfo.length, (index) => false,
        growable: true);
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
            //onChanged: init(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search...',
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: appsTimerInfoFiltered.length,
        itemBuilder: (context, index) {
          String appPkgName =
              appsTimerInfoFiltered.keys.elementAt(index).toString();
          List<String> values = appsTimerInfoFiltered[appPkgName];
          String appName = values[0];
          bool isActive = values[1] == '1' ? true : false;
          return Card(
            child: ListTile(
              trailing: isActive ? Icon(Icons.access_time) : null,
              title: GestureDetector(
                onTap: () => InstalledApps.startApp(appPkgName),
                onLongPress: () => InstalledApps.openSettings(appPkgName),
                onDoubleTap: () {
                  int focusIndex = 0;
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
                                  if (((_timeController[0].text as int) < 24 &&
                                          (_timeController[2].text as int) <
                                              24) &&
                                      ((_timeController[1].text as int) < 60 &&
                                          (_timeController[3].text as int) <
                                              60)) {
                                    UserPreferences.setData(appPkgName, [
                                      appName,
                                      isActive ? '1' : '0',
                                      '${_timeController[0]}:${_timeController[1]}',
                                      '${_timeController[2]}:${_timeController[3]}'
                                    ]);
                                  }
                                  setState(() {});
                                },
                                child: Text('Save')),
                          ],
                          title: Text('Activate timer'),
                          content: Column(
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
                                  }),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      focusNode: _focusNodes[0],
                                      onFieldSubmitted: (value) {
                                        focusIndex++;
                                        FocusScope.of(context).requestFocus(
                                            _focusNodes[focusIndex]);
                                      },
                                      maxLength: 2,
                                      keyboardType: TextInputType.number,
                                      controller: _timeController[0],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'hh',
                                      ),
                                    ),
                                  ),
                                  Text(' : '),
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 2,
                                      keyboardType: TextInputType.number,
                                      focusNode: _focusNodes[1],
                                      onFieldSubmitted: (value) {
                                        focusIndex++;
                                        FocusScope.of(context).requestFocus(
                                            _focusNodes[focusIndex]);
                                      },
                                      controller: _timeController[1],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'mm',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp('[0-3]'))
                                      ],
                                      maxLength: 2,
                                      focusNode: _focusNodes[2],
                                      onFieldSubmitted: (value) {
                                        focusIndex++;
                                        FocusScope.of(context).requestFocus(
                                            _focusNodes[focusIndex]);
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _timeController[2],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'hh',
                                      ),
                                    ),
                                  ),
                                  Text(' : '),
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 2,
                                      focusNode: _focusNodes[3],
                                      onFieldSubmitted: (value) {
                                        focusIndex++;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _timeController[3],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'mm',
                                      ),
                                    ),
                                  ),
                                ],
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
