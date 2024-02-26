import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'apps_card.dart';

class AppsList extends StatelessWidget {
  final List<AppLockInfo>? appLockInfoList;
  final bool _isReverse = true;
  const AppsList({super.key, required this.appLockInfoList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (e) => Navigator.pop(context),
      child: ListView.builder(
        padding: const EdgeInsets.only(
            bottom: 70,
            top: 40), //TODO: trovare una soluzione migliore del padding
        reverse: _isReverse,
        itemCount: appLockInfoList?.length,
        itemBuilder: (context, index) {
          //AppLockInfo appLockInfo= _appLockInfoList[index];
          return appLockInfoList![index].isVisible == true
              ? AppsCard(
                  appLockInfo: appLockInfoList![index],
                )
              : const Divider(
                  height: 0,
                );
        },
      ),
    );
  }
}
