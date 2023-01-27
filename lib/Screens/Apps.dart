import 'package:focus_launcher/Services/apps_list.dart';
import 'package:flutter/material.dart';
import 'package:focus_launcher/Services/apps_list.dart';
import 'package:focus_launcher/Services/GetApps.dart';
import 'package:intl/intl.dart';

class Apps extends StatefulWidget {
  const Apps({required Key key}):super(key: key);
  @override
  State<Apps> createState() => _AppsState();
}
class _AppsState extends State<Apps> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Object>(
                            builder: (BuildContext context) => AppsListScreen()),
                      );
                    },
                    child: Text('Applications list')),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
