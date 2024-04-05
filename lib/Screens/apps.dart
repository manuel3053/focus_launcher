import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:focus_launcher/Screens/apps_list.dart';
import 'package:flutter/material.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});
  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Future<List<AppLockInfo>> _appLockInfoList =
      UserPreferences.getAppLockInfoList();
  bool _isReverse = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _appLockInfoList,
      builder:
          (BuildContext context, AsyncSnapshot<List<AppLockInfo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
                onHorizontalDragEnd: (e) => Navigator.pop(context),
                child: AppsList(
                  appLockInfoList: snapshot.data
                      ?.where((app) => app.isVisible == true)
                      .toList(),
                  isReverse: _isReverse,
                )),
            bottomSheet: TextField(
              //Quando la textfield ha il focus continua a far ricaricare il widget
              //autofocus: true,
              controller: _searchController,
              onChanged: (String filter) {
                setState(() {
                  filterAppTimerInfo(filter, snapshot.data);
                  if (filter.isEmpty) {
                    _isReverse = false;
                  } else {
                    _isReverse = true;
                  }
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                labelText: 'Search...',
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  filterAppTimerInfo(String filter, List<AppLockInfo>? appLockInfoList) {
    for (var element in appLockInfoList!) {
      if (!(element.appName.toLowerCase()).startsWith(filter)) {
        element.isVisible = false;
      } else {
        element.isVisible = true;
      }
    }
  }
}
