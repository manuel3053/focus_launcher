import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'apps_card.dart';

class AppsList extends StatefulWidget {
  final List<AppLockInfo>? appLockInfoList;
  final bool isReverse;
  const AppsList({super.key, required this.appLockInfoList, required this.isReverse});

  @override
  State<AppsList> createState() => _AppsListState();
}

class _AppsListState extends State<AppsList>{
  late ScrollController controller;
  

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
        reverse: widget.isReverse,
        itemCount: widget.appLockInfoList?.length,
        //itemCount: 5,
        itemBuilder: (context, index) {
          //AppLockInfo appLockInfo= _appLockInfoList[index];
          return widget.appLockInfoList![index].isVisible == true
              ? AppsCard(
            appLockInfo: widget.appLockInfoList![index],
          )
              : const SizedBox.shrink();
        },
      ),
    );
  }

}
