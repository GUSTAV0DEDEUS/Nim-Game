import 'package:flutter/material.dart';
import 'package:nim/view/screens/welcome/gameIntro/game_intro.dart';
import 'package:nim/view/screens/welcome/nim.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Dogica',
      ),
      debugShowCheckedModeBanner: false,
      home: const GameIntroScreen(),
    );
  }
}
