import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';
import 'package:provider/provider.dart';

import '../Provider/app_provider.dart';

class LockSetup extends StatefulWidget {
  const LockSetup({super.key, required this.appLockInfo});
  final AppLockInfo appLockInfo;

  @override
  State<LockSetup> createState() => LockSetupState();
}

class LockSetupState extends State<LockSetup> {
  late List<DropdownMenuItem> _hours = [];
  late List<DropdownMenuItem> _minutes = [];
  late AppLockInfo _appLockInfo;
  int _hourStart = 0;
  int _minuteStart = 0;
  int _hourEnd = 0;
  int _minuteEnd = 0;
  bool _isActive = false;
  List<Widget> lockForm = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Discard')),
        TextButton(
            onPressed: () {
              /*_appLockInfo.isActive = _isActive;
              _appLockInfo.startAppMinuteLock = _hourStart * 60 + _minuteStart;
              _appLockInfo.endAppMinuteLock = _hourEnd * 60 + _minuteEnd;*/
              context.read<AppLockInfoProvider>().updateAppLock(_appLockInfo.appPkgName, _isActive, _hourStart * 60 + _minuteStart, _hourEnd * 60 + _minuteEnd);
              Navigator.pop(context);
            },
            child: const Text('Save')),
      ],
      title: const Text('Activate AppLockTimer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Switch(
              value: _isActive,
              onChanged: (bool value) {
                _isActive = value;
                setState(() {});
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                items: _hours,
                onChanged: (v) {
                  setState(() {
                    _hourStart = v;
                  });
                },
                value: _hourStart,
              ),
              const Text(' : '),
              DropdownButton(
                items: _minutes,
                onChanged: (v) {
                  setState(() {
                    _minuteStart = v;
                  });
                },
                value: _minuteStart,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                items: _hours,
                onChanged: (v) {
                  setState(() {
                    _hourEnd = v;
                  });
                },
                value: _hourEnd,
              ),
              const Text(' : '),
              DropdownButton(
                items: _minutes,
                onChanged: (v) {
                  setState(() {
                    _minuteEnd = v;
                  });
                },
                value: _minuteEnd,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _appLockInfo = widget.appLockInfo;
    _hourStart = _appLockInfo.startAppMinuteLock~/60;
    _minuteStart = _appLockInfo.startAppMinuteLock%60;
    _hourEnd = _appLockInfo.endAppMinuteLock~/60;
    _minuteEnd = _appLockInfo.endAppMinuteLock%60;
    _isActive = _appLockInfo.isActive;
    _hours = List.generate(
        24,
            (index) => DropdownMenuItem(
          value: index,
          child:
          Text(index < 10 ? '0${index.toString()}' : index.toString()),
        ));
    _minutes = List.generate(
        60,
            (index) => DropdownMenuItem(
          value: index,
          child:
          Text(index < 10 ? '0${index.toString()}' : index.toString()),
        ));
  }
}


