import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/Screens/Splash_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Splash_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}






