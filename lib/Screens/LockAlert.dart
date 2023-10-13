// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class LockAlert extends StatefulWidget {
  const LockAlert({
    Key? key,
    required this.end,
  }) : super(key: key);

  final String end;

  @override
  _LockAlertState createState() => _LockAlertState();
}

class _LockAlertState extends State<LockAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Hey, go do your things, don't waste your time till ${widget.end}"),
    );
  }
}
