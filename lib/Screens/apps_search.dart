import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/app_provider.dart';
import 'apps.dart';
/*
class AppsSearch extends StatefulWidget {
  final List<AppLockInfo> appList;
  const AppsSearch({super.key, required this.appList});
  @override
  State<AppsSearch> createState() => _AppsSearchState();
}

class _AppsSearchState extends State<AppsSearch> {
  late TextEditingController _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _searchController,
      onChanged: (String filter) {
        setState(() {
          filterAppTimerInfo(filter, widget.appList);
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
    );
  }

  List<AppLockInfo> filterAppTimerInfo(String filter, List<AppLockInfo> appLockInfoList) {
    for (var element in appLockInfoList) {
      if (!(element.appName.toLowerCase()).startsWith(filter)) {
        element.isVisible = false;
      } else {
        element.isVisible = true;
      }
    }
    return appLockInfoList;
  }
}
*/