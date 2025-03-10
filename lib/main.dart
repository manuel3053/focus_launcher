import 'package:flutter/material.dart';
import 'package:focus_launcher/Data/app_repository_local.dart';
import 'package:focus_launcher/Ui/Views/apps_view_model.dart';
import 'package:focus_launcher/Ui/Widgets/apps.dart';

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
  late AppRepositoryLocal appRepositoryLocal;
  late AppsViewModel appsViewModel;

  @override
    void initState() {
      appRepositoryLocal = AppRepositoryLocal();
      appsViewModel = AppsViewModel(appRepository: appRepositoryLocal);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
      child: IconButton(
        icon: Icon(Icons.apps),
        iconSize: 50,
        onPressed: () {
        appsViewModel.loadApps.execute();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppsScreen(
                viewModel: appsViewModel,
                ),
              ));
        }
      ),
      ),
    );
  }
}
