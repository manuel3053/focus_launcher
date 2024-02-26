
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
  late TextEditingController _searchController;
  late Future<List<AppLockInfo>> _appLockInfoList;
  bool _isReverse = false;
  int counter = 0;

  @override
  void initState() {
    //_appLockInfoList = Provider.of<AppLockInfoProvider>(context, listen: false).appLockInfoList;
    _appLockInfoList = UserPreferences.getAppLockInfoList();
    //counter = _appLockInfoList.length;
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
      body: FutureBuilder(
        future: _appLockInfoList,
        builder: (BuildContext context, AsyncSnapshot<List<AppLockInfo>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            return AppsList(appLockInfoList: snapshot.data);
          }
          else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
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

/*
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
              contentPadding: EdgeInsets.only(left: 20),
              border: InputBorder.none,
              labelText: 'Search...',
            ),
          ),
          body: GestureDetector(
            onHorizontalDragEnd: (e) => Navigator.pop(context),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 70,top: 40), //TODO: trovare una soluzione migliore del padding
              reverse: _isReverse,
              itemCount: counter,
              itemBuilder: (context, index) {
                //AppLockInfo appLockInfo= _appLockInfoList[index];
                return _appLockInfoList[index].isVisible==true ? AppsCard(appLockInfo: _appLockInfoList[index],):const Divider(height: 0,);
              },
            ),
          ),
        );
*/