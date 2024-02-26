import 'package:flutter/material.dart';
import 'package:focus_launcher/Functions/user_preferences.dart';
import 'package:focus_launcher/Provider/app_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'Screens/Apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(ChangeNotifierProvider<AppLockInfoProvider>(
    child: const MyApp(),
    create: (context) => AppLockInfoProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: const TextTheme(labelLarge: TextStyle(fontSize: 40))),
      home: const LauncherHomepage(),
    );
  }
}

class LauncherHomepage extends StatefulWidget {
  const LauncherHomepage({super.key});

  @override
  State<LauncherHomepage> createState() => _LauncherHomepageState();
}

class _LauncherHomepageState extends State<LauncherHomepage> {

  @override
  void initState() {
    super.initState();
    Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
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
            ),
            Card(
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
                onLongPress: (){
                  Provider.of<AppLockInfoProvider>(context, listen: false).generateAppLockInfoList();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Completed"),
                  ));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
