import 'package:flutter/material.dart';
import 'Screens/apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          //useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,
                  brightness: Brightness.dark
          ),
          brightness: Brightness.dark
      ),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: ColoredBox(
        color: Colors.black,
          child: Center(child: GestureDetector(
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
          ))),
    );
  }
}
