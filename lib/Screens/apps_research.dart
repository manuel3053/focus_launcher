import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/app_provider.dart';
import 'apps.dart';
/*
class HomeButton extends StatefulWidget {
  const HomeButton({super.key});
  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppsScreen(),
              ));
        },
        child: const Icon(
          Icons.apps,
          size: 50,
        ),
        onLongPress: () {
          Provider.of<AppLockInfoProvider>(context, listen: false)
              .generateAppLockInfoList();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Completed"),
          ));
        },
      ),
    );
  }
}
*/