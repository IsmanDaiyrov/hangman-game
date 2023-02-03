import 'package:flutter/material.dart';
import 'package:hangman/gamescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // turns off a little "DEBUG" banner that indicates that the app is in debug mode
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}
