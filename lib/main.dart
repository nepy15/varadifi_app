import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varadifi_app/screens/home_layout.dart';

 void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor:Color(0xFF171717),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor:Color.fromARGB(255, 0, 2, 0),
          title: const ImageIcon(AssetImage("assets/VaradifiIcon.png"), color: Color(0xFFFFFFFF), size: 50.0,),
        ),
        body: HomePage(),
      )
    );
  }
}
