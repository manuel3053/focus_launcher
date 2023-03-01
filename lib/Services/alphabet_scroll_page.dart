import 'package:azlistview/azlistview.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class _AZItem extends ISuspensionBean{
  final String tag;
  final Application app;

  _AZItem({
    required this.tag,
    required this.app,
  });

  @override
  String getSuspensionTag() => tag;
}

class AlphabetScrollPage extends StatefulWidget{
  final Set<Application> items;
  final ValueChanged<String> onClickedItem;

  const AlphabetScrollPage({
    required Key key,
    required this.items,
    required this.onClickedItem,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage>{
  List<_AZItem> items=[];
  /*/List<AppUsageInfo> infos = [];

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(startDate, endDate);
      setState(() => infos = infoList);
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }*/


  @override
  void initState(){
    super.initState();
    items=widget.items.map((item) => _AZItem(
        app: item,
        tag: item.appName[0].toUpperCase())).toList();

    SuspensionUtil.sortListBySuspensionTag(items);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      padding: const EdgeInsets.all(5),
        data: items,
        itemCount: items.length,
        itemBuilder: (context, index){
          final item = items[index];
          return _buildListItem(item);
        }
    );


  }

  Widget _buildListItem(_AZItem item){

    return ListTile(
      title: Text(item.app.appName),
      onTap: () => item.app.openApp(),
      onLongPress: () => longPress(context, item.app),
    );
  }

  void longPress(BuildContext context, Application app,) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: Text(app.appName, textAlign: TextAlign.center,),
            actions: <Widget>[
              TextButton(onPressed: () => app.uninstallApp(), child: const Text('Disinstalla')),
              TextButton(onPressed: () => app.openSettingsScreen(), child: const Text('Impostazioni'))
            ],
          );
        }
    );

  }



}
