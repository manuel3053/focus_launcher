import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsListScreen extends StatefulWidget {
  @override
  _AppsListScreenState createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AppsListScreenContent(key: UniqueKey()),);
  }
}

class _AppsListScreenContent extends StatelessWidget {
  const _AppsListScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        else {
          List<Application> apps = data.data!;

          return Scrollbar(
            child: ListView.builder(
                padding: EdgeInsets.all(40),
                itemCount: apps.length,
                itemBuilder: (BuildContext context, int position) {
                  Application app = apps[position];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: app is ApplicationWithIcon
                            ? CircleAvatar(
                          backgroundImage: MemoryImage(app.icon),
                          backgroundColor: Colors.white,
                        )
                            : null,
                        onTap: () => onAppClicked(context, app),
                        title: Text('${app.appName}'),
                      ),
                      const Divider(height: 1.0,)
                    ],
                  );
                },
            ),
          );
        }
      },
    );
  }

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(app.appName),
            actions: <Widget>[
              _AppButtonAction(
                label: 'Open app',
                onPressed: () => app.openApp(),
              ),
              _AppButtonAction(
                label: 'Open app settings',
                onPressed: () => app.openSettingsScreen(),
              ),
              _AppButtonAction(
                label: 'Uninstall app',
                //onPressed: () async => app.uninstallApp(),
                onPressed: () async => {},
              ),
            ],
          );
        });
  }
}

class _AppButtonAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  _AppButtonAction({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Text(label),
    );
  }
}