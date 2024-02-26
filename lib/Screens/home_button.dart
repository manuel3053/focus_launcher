import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/app_provider.dart';
import 'apps.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

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
        onLongPress: () async {
          Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Completed"),
          ));
        },
      ),
    );
  }

}