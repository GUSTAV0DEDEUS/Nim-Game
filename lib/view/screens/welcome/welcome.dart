import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(65, 57, 96, 1),
        body: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/background.jpeg',
                height: 400,
              ),
              Text("Seja bem vindo")
            ],
          ),
        ));
  }
}
