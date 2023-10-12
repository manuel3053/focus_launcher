// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({
    Key? key,
    required this.end,
  }) : super(key: key);

  final String end;

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Hey, go do your things, don't waste your time till ${widget.end}"),
    );
  }
}
