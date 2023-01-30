import 'package:azlistview/azlistview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _AZItem extends ISuspensionBean{
  String title;
  String tag;

  _AZItem({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;
}

class AlphabetScrollPage extends StatefulWidget{
  final List<String> items;
  final ValueChanged<String> onClickedItem;

  AlphabetScrollPage({
    required Key key,
    required this.items,
    required this.onClickedItem,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage>{
  List<_AZItem> items=[];
  int i=0;
  @override
  void initState(){
    super.initState();
    //for(i=0; i<widget.items.length; i++) {
      //widget.items.map((item) => _AZItem(title: item, tag: item[0].toUpperCase())).toList();
    //}
    for(i=0; i<widget.items.length; i++){
      items[i].title=widget.items[i];
      items[i].tag=widget.items[0].toUpperCase();
      //items.add(tmp_item);
    }

    SuspensionUtil.sortListBySuspensionTag(this.items);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(items.length);
    }
    return AzListView(
      padding: const EdgeInsets.all(16),
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
      title: Text(item.title),
      tileColor: Colors.red,
      onTap: () => widget.onClickedItem(item.title),
    );
  }

}
