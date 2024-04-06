import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'apps_card.dart';

class AppsList extends StatelessWidget {
  final List<AppLockInfo>? appLockInfoList;
  final bool isReverse;
  const AppsList({super.key, required this.appLockInfoList, required this.isReverse});



  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: const EdgeInsets.only(
          bottom: 70,
          top: 40), //TODO: trovare una soluzione migliore del padding
      reverse: isReverse,
      itemCount: appLockInfoList?.length,
      //itemCount: 5,
      itemBuilder: (context, index) {
        return AppsCard(
          appLockInfo: appLockInfoList![index],
        );
      },
    );
  }

}