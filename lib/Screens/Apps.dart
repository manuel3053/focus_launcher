import 'package:flutter/material.dart';
import 'package:focus_launcher/Services/alphabet_scroll_page.dart';

class Apps extends StatefulWidget {
  const Apps({required Key key}):super(key: key);
  @override
  State<Apps> createState() => _AppsState();
}
class _AppsState extends State<Apps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlphabetScrollPage(
        items: ['jighen', 'marianna', 'Piero',],
        key: UniqueKey(),
        onClickedItem: (String value) {  },
      ),
    );
  }
}
