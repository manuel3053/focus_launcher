import 'package:flutter/material.dart';
import 'package:focus_launcher/Functions/minutes_to_time_format.dart';
class LockAlert extends StatefulWidget {
  const LockAlert({
    super.key,
    required this.end,
  });

  final int end;

  @override
  LockAlertState createState() => LockAlertState();
}

class LockAlertState extends State<LockAlert> with MinutesToTimeFormat{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Hey, go do your things, don't waste your time till ${hhmm(widget.end)}"),
    );
  }
}
