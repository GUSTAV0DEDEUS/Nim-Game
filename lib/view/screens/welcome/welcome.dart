import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nim/view/screens/gameSetup/game_setup.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const GameSetup()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(114, 41, 148, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/background.png',
                height: 400,
              ),
              const SizedBox(height: 20),
              const Text(
                "Bem-vindo a Eldirc, onde começa sua jornada.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Dogica Pixel",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              )
            ],
          ),
        ));
  }
}
