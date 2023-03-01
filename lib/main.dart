import 'package:flutter/material.dart';
import 'Screens/Apps.dart';
import 'Screens/Home.dart';
import 'Screens/Widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark,),
      home: LauncherScreen(key: UniqueKey(),),
    );
  }
}

class LauncherScreen extends StatefulWidget{
  LauncherScreen({required Key key}):super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen>{
  /* Questo widget ha il solo scopo di gestire lo scroll delle tre schermate tramite PageView;
     Di seguito le varie schermate con le funzionalità pensate/sviluppate
   - Widgets: inserisci e visualizza widget di sistema scorribili lungo l'asse verticale (DA SVILUPPARE)
   - Home:
      # visualizzazione data e ora (IMPLEMENTATA)
      # visualizzazione carica batteria (IMPLEMENTATA)
      # visualizzazione app preferite dall'utente (DA SVILUPPARE)
      # eventuali bottoni per accedere rapidamente alle funzionalità essenziali del telefono (DA SVILUPPARE)
   - Apps: visualizzazione app dispositivo (IN SVILUPPO)


   - Settings (non accessibile da PageView): TOTALMENTE DA SVILUPPARE

   */

  final controller = PageController(initialPage: 1);

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        controller: controller,
        children: <Widget>[
          Widgets(key: UniqueKey(),),
          Home(key: UniqueKey(),),
          Apps(key: UniqueKey(),),
        ],
      ),
    );
  }
}
