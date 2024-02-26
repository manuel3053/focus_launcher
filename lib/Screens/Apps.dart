import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:focus_launcher/Screens/LockAlert.dart';
import 'package:focus_launcher/Screens/LockSetup.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Functions/minutes_to_time_format.dart';
import '../Provider/app_provider.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});
  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> with MinutesToTimeFormat {
  late TextEditingController _searchController;
  List<AppLockInfo> _appLockInfoList = [];
  bool _isReverse = false;
  int counter = 0;

  @override
  void initState() {
    _appLockInfoList = Provider.of<AppLockInfoProvider>(context, listen: false).appLockInfoList;
    counter = _appLockInfoList.length;
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
      bottomSheet: TextField(
        autofocus: true,
        controller: _searchController,
        onChanged: (String filter) {
          setState(() {
            _appLockInfoList = filterAppTimerInfo(filter, _appLockInfoList);
            if(filter.isEmpty) {
              _isReverse = false;
            }
            else{
              _isReverse = true;
            }
          }
          );
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: 'Search...',
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (e) => Navigator.pop(context),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 70), //TODO: trovare una soluzione migliore del padding
          reverse: _isReverse,
          itemCount: counter,
          itemBuilder: (context, index) {
            AppLockInfo appLockInfo= _appLockInfoList[index];
            return appLockInfo.isVisible==true ? GestureDetector(
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      trailing: appLockInfo.isLocked
                          ? const Icon(Icons.access_time)
                          : null,
                      title: Text(appLockInfo.appName),
                    ),
                  ),
                )): const Divider(height: 0,);
          },
        ),
      ),
    );
  }

  void appLockCheck(AppLockInfo appLockInfo, int currentTime) {
    if (currentTime <= appLockInfo.endAppMinuteLock && currentTime >= appLockInfo.startAppMinuteLock && appLockInfo.isLocked) {
      String endLock = hhmm(appLockInfo.getEndLock());
      showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return LockAlert(end: appLockInfo.endAppMinuteLock);
          });
    } else {
      appLockInfo.resetEndLock();
      InstalledApps.startApp(appLockInfo.appPkgName);
      Navigator.pop(context);
    }
  }


  List<AppLockInfo> filterAppTimerInfo(String filter, List<AppLockInfo> appLockInfoList) {
    for (var element in appLockInfoList) {
      if (!(element.appName.toLowerCase()).startsWith(filter)) {
        element.isVisible=false;
      }
      else{
        element.isVisible=true;
      }
    }
    return appLockInfoList;
  }
}
