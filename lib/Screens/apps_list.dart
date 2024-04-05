import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'apps_card.dart';

class AppsList extends StatelessWidget {
  final List<AppLockInfo>? appLockInfoList;
  final bool isReverse;
  const AppsList({super.key, required this.appLockInfoList, required this.isReverse});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (e) => Navigator.pop(context),
      child: ListView.builder(

        //addAutomaticKeepAlives: false,
        //addRepaintBoundaries: false,
        padding: const EdgeInsets.only(
            bottom: 70,
            top: 40), //TODO: trovare una soluzione migliore del padding
        reverse: isReverse,
        itemCount: appLockInfoList?.length,
        //itemCount: 5,
        itemBuilder: (context, index) {
          //AppLockInfo appLockInfo= _appLockInfoList[index];
          return appLockInfoList![index].isVisible == true
              ? AppsCard(
            appLockInfo: appLockInfoList![index],
          )
              : const SizedBox.shrink();
        },
      ),
    );
  }

}