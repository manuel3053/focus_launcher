import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:focus_launcher/Screens/LockAlert.dart';
import 'package:focus_launcher/Screens/LockSetup.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter/material.dart';

import '../Functions/minutes_to_time_format.dart';

class AppsScreen extends StatefulWidget {
  List<AppLockInfo> appLockInfoList;
  AppsScreen({super.key, required this.appLockInfoList});
  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> with MinutesToTimeFormat {
  late TextEditingController _searchController;
  late List<AppLockInfo> _appLockInfoList = [];
  List<AppLockInfo> _appLockInfoFilteredList = [];
  var appsTimerInfoFiltered = {};


  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    _appLockInfoList = widget.appLockInfoList;
    _appLockInfoFilteredList = widget.appLockInfoList;
    _searchController = TextEditingController();
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
            onChanged: (String filter) {
              setState(() {
                _appLockInfoFilteredList =
                    filterAppTimerInfo(filter, _appLockInfoList);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search...',
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (e) => Navigator.pop(context),
        child: ListView.builder(
          itemCount: _appLockInfoFilteredList.length,
          itemBuilder: (context, index) {
            AppLockInfo appLockInfo = _appLockInfoFilteredList[index];
            int currentTime = TimeOfDay.now().hour*60 + TimeOfDay.now().minute;
            return GestureDetector(
              onTap: () => appLockCheck(appLockInfo, currentTime),
              onLongPress: () =>
                  InstalledApps.openSettings(appLockInfo.appPkgName),
              onDoubleTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LockSetup(appLockInfo: appLockInfo);
                    });
              },
              child: Card(
                child: ListTile(
                  trailing: appLockInfo.isActive ? const Icon(Icons.access_time) : null,
                  title: Text(appLockInfo.appName),
                  ),
                )
            );
          },
        ),
      ),
    );
  }

  void appLockCheck(AppLockInfo appLockInfo, int currentTime){
    if(currentTime>=appLockInfo.startAppMinuteLock && currentTime<=appLockInfo.endAppMinuteLock){
      String endLock = hhmm(appLockInfo.endAppMinuteLock);
      showDialog(context: context, builder: (BuildContext buildContext){
        return LockAlert(end: endLock);
      });
    }
    else{
      InstalledApps.startApp(appLockInfo.appPkgName);
    }
  }

  List<AppLockInfo> filterAppTimerInfo(String filter, List<AppLockInfo> appLockInfoList) {
    List<AppLockInfo> appLockInfoListReturn = [];
    for(AppLockInfo appLockInfo in appLockInfoList){
      if(appLockInfo.appName.toLowerCase().contains(filter)){
        appLockInfoListReturn.add(appLockInfo);
      }
    }

    /*
    for (final key in widget.appsTimerInfo.keys) {
      List<String> values = widget.appsTimerInfo[key];
      if (values[0].toString().toLowerCase().contains(val)) {
        appsTimerInfoFiltered[key] = values;
      }
    }*/
    return appLockInfoListReturn;
  }

}
