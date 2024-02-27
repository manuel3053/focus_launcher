import 'package:flutter/material.dart';
import 'package:focus_launcher/Provider/app_provider.dart';
import 'package:focus_launcher/Screens/home_button.dart';
import 'package:focus_launcher/Screens/home_widget.dart';
import 'package:provider/provider.dart';

import 'Functions/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  /*runApp(ChangeNotifierProvider<AppLockInfoProvider>(
    child: const MyApp(),
    create: (context) => AppLockInfoProvider(),
  ));*/
  runApp(const MyApp());
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
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //HomeWidget(),
            HomeButton(),
          ],
        ),
      ),
    );
  }
}
