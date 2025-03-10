import 'package:flutter/material.dart';
import 'package:focus_launcher/Ui/Views/apps_view_model.dart';
import 'package:focus_launcher/Ui/Widgets/apps_card.dart';

class AppsScreen extends StatefulWidget {
  final AppsViewModel viewModel;
  const AppsScreen({super.key, required this.viewModel});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, _) {
                if (widget.viewModel.loadApps.running) {
                  return Center(
                    child: const CircularProgressIndicator(color: Colors.white),
                    // child: Text(widget.viewModel.count.toString()),
                  );
                }
                if (widget.viewModel.loadApps.error) {
                  return const Text("mi spiace");
                }
                return Expanded(
                  child: ListView.builder(
                    reverse: showSearch,
                    itemCount: widget.viewModel.apps.length,
                    itemBuilder: (context, index) {
                      return AppsCard(
                        appInfo: widget.viewModel.apps.elementAt(index),
                      );
                    },
                  ),
                );
              },
            ),
            showSearch
                ? TextField(
                  autofocus: true,
                  onChanged: (String s) {
                    widget.viewModel.setFilter(s);
                  },
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Search...',
                  ),
                )
                : SizedBox.shrink(),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "Refresh",
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  widget.viewModel.loadApps.execute();
                });
              },
              child: Icon(Icons.refresh),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "Search",
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  showSearch = !showSearch;
                });
              },
              child: Icon(Icons.search_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
