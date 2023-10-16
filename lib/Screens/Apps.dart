import 'package:flutter/gestures.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:focus_launcher/Screens/LockAlert.dart';
import 'package:focus_launcher/Screens/LockSetup.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter/material.dart';

import '../Functions/minutes_to_time_format.dart';

class AppsScreen extends StatefulWidget {
  final List<AppLockInfo> appLockInfoList;
  const AppsScreen({super.key, required this.appLockInfoList});
  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> with MinutesToTimeFormat {
  late TextEditingController _searchController;
  late List<AppLockInfo> _appLockInfoList = [];
  List<AppLockInfo> _appLockInfoFilteredList = [];
  bool isReverse = false;

  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    _appLockInfoList = widget.appLockInfoList;
    _appLockInfoFilteredList = _appLockInfoList;
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
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextField(
          autofocus: true,
          controller: _searchController,
          onChanged: (String filter) {
            setState(() {
              _appLockInfoFilteredList = filterAppTimerInfo(filter, _appLockInfoList);
              AppLockInfo appLockInfoFiller = AppLockInfo(
                  appName: 'no results',
                  appPkgName: 'no results',
                  startAppMinuteLock: 0,
                  endAppMinuteLock: 0,
                  isActive: false);
              if(filter.isEmpty){
                isReverse = false;
                if(_appLockInfoFilteredList.contains(appLockInfoFiller)){
                  _appLockInfoFilteredList.remove(appLockInfoFiller);
                }
              }
              else{
                isReverse = true;
                if(!_appLockInfoFilteredList.contains(appLockInfoFiller)){
                  _appLockInfoFilteredList.insert(0,appLockInfoFiller);
                }
              }
            });
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: 'Search...',
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (e) => Navigator.pop(context),
        child: ListView.builder(
          reverse: isReverse,
          itemCount: _appLockInfoFilteredList.length,
          itemBuilder: (context, index) {
            AppLockInfo appLockInfo = _appLockInfoFilteredList[index];
            return GestureDetector(
                onTap: () {
                  int currentTime =
                      TimeOfDay.now().hour * 60 + TimeOfDay.now().minute;
                  appLockInfo.setEndLock(currentTime + 15);
                  appLockCheck(appLockInfo, currentTime);
                },
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
                    trailing: appLockInfo.isActive
                        ? const Icon(Icons.access_time)
                        : null,
                    title: Text(appLockInfo.appName),
                  ),
                ));
          },
        ),
      ),
    );
  }

  void appLockCheck(AppLockInfo appLockInfo, int currentTime) {
    if (currentTime <= appLockInfo.getEndLock() && appLockInfo.isActive) {
      String endLock = hhmm(appLockInfo.getEndLock());
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return LockAlert(end: endLock);
          });
    } else {
      appLockInfo.resetEndLock();
      InstalledApps.startApp(appLockInfo.appPkgName);
      Navigator.pop(context);
    }
  }

  List<AppLockInfo> filterAppTimerInfo(
      String filter, List<AppLockInfo> appLockInfoList) {
    List<AppLockInfo> appLockInfoListReturn = [];
    for (AppLockInfo appLockInfo in appLockInfoList) {
      if ((appLockInfo.appName.toLowerCase()).startsWith(filter)) {
        appLockInfoListReturn.add(appLockInfo);
      }
    }
    return appLockInfoListReturn;
  }
}
