import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('sono stato caricato');
    }
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: Stream.periodic(const Duration(minutes: 1)),
          builder: (context, snapshot) {
            return Text(
              DateFormat('MM/dd/yyyy\nHH:mm').format(DateTime.now()),
              textScaler: const TextScaler.linear(3),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}