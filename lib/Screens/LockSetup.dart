import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Functions/user_preferences.dart';

class LockSetup extends StatefulWidget{
  LockSetup({super.key, required this.appPkgName});
  final List<String> appInfo;

  @override
  State<LockSetup> createState() => LockSetupState();
}

class LockSetupState extends State<LockSetup>{
  late List<DropdownMenuItem> _hour = [];
  late List<DropdownMenuItem> _minute = [];

  @override
  void initState(){
    _hour = List.generate(
        24,
            (index) => DropdownMenuItem(
          value: index < 10 ? '0${index.toString()}' : index.toString(),
          child:
          Text(index < 10 ? '0${index.toString()}' : index.toString()),
        ));
    _minute = List.generate(
        60,
            (index) => DropdownMenuItem(
          value: index < 10 ? '0${index.toString()}' : index.toString(),
          child:
          Text(index < 10 ? '0${index.toString()}' : index.toString()),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      actions: [
        TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Discard')),
        TextButton(
            onPressed: () {
              UserPreferences.setData(
                  widget.appPkgName, [
                appName,
                isActive ? '1' : '0',
                '${dropdownValues[0]}:${dropdownValues[1]}',
                '${dropdownValues[2]}:${dropdownValues[3]}'
              ]);
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Save')),
      ],
      title: const Text('Activate timer'),
      content: StatefulBuilder(
        builder: (BuildContext context,
            StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                  value: isActive,
                  onChanged: (bool value) {
                    isActive = value;
                    List<String> valuesTmp =
                        values;
                    valuesTmp[1] =
                    value ? '1' : '0';
                    UserPreferences.setData(
                        widget.appPkgName, valuesTmp);
                    setState(() {});
                  }),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    items: _hour,
                    onChanged: (v) {
                      setState(() {
                        dropdownValues[0] = v;
                      });
                    },
                    value: dropdownValues[0],
                  ),
                  const Text(' : '),
                  DropdownButton(
                    items: _minute,
                    onChanged: (v) {
                      setState(() {
                        dropdownValues[1] = v;
                      });
                    },
                    value: dropdownValues[1],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                    items: _hour,
                    onChanged: (v) {
                      setState(() {
                        dropdownValues[2] = v;
                      });
                    },
                    value: dropdownValues[2],
                  ),
                  const Text(' : '),
                  DropdownButton(
                    items: _minute,
                    onChanged: (v) {
                      setState(() {
                        dropdownValues[3] = v;
                      });
                    },
                    value: dropdownValues[3],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}