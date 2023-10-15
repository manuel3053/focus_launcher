import 'package:flutter/material.dart';

class LockAlert extends StatefulWidget {
  const LockAlert({
    Key? key,
    required this.end,
  }) : super(key: key);

  final String end;

  @override
  LockAlertState createState() => LockAlertState();
}

class LockAlertState extends State<LockAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Hey, go do your things, don't waste your time till ${widget.end}"),
    );
  }
}
