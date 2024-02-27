import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'apps_card.dart';

class AppsPages extends StatefulWidget {
  final List<AppLockInfo>? appLockInfoList;
  final bool _isReverse = true;
  const AppsPages({super.key, required this.appLockInfoList});

  @override
  State<AppsPages> createState() => _AppsPagesState();
}

class _AppsPagesState extends State<AppsPages>{
  late ScrollController controller;
  List<Widget> children = [];
  @override
  void initState() {
    widget.appLockInfoList?.forEach((app) {
      children.add(AppsCard(appLockInfo: app));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (e) => Navigator.pop(context),
      child: Wrap(
        children: children,
      ),
    );
  }

}
