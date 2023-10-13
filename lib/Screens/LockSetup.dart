import 'package:flutter/material.dart';
import 'package:focus_launcher/Classes/app_lock_info.dart';

import '../Functions/user_preferences.dart';

class LockSetup extends StatefulWidget {
  const LockSetup({super.key, required this.appLockInfo});
  final AppLockInfo appLockInfo;

  @override
  State<LockSetup> createState() => LockSetupState();
}

class LockSetupState extends State<LockSetup> {
  late List<DropdownMenuItem> _hours = [];
  late List<DropdownMenuItem> _minutes = [];
  int _hourStart = 0;
  int _minuteStart = 0;
  int _hourEnd = 0;
  int _minuteEnd = 0;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();

    _hourStart = widget.appLockInfo.startAppMinuteLock~/60;
    _minuteStart = widget.appLockInfo.startAppMinuteLock%60;
    _hourEnd = widget.appLockInfo.endAppMinuteLock~/60;
    _minuteEnd = widget.appLockInfo.endAppMinuteLock%60;
    _isActive = widget.appLockInfo.isActive;
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
              widget.appLockInfo.isActive = _isActive;
              widget.appLockInfo.startAppMinuteLock = _hourStart * 60 + _minuteStart;
              widget.appLockInfo.endAppMinuteLock = _hourEnd * 60 + _minuteEnd;
              UserPreferences.setAppLockInfo(widget.appLockInfo);
              setState(() {});
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
}


