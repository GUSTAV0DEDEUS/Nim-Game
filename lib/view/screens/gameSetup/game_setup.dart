import 'package:flutter/material.dart';
import 'package:nim/view/screens/game/game.dart';
import 'package:nim/viewModel/nim.controller.dart';

class GameSetup extends StatefulWidget {
  const GameSetup({super.key});

  @override
  State<GameSetup> createState() => _GameSetupState();
}

class _GameSetupState extends State<GameSetup> {
  int _selectedFibonacci = 0;
  int _selectedNumber = 0;
  final List<int> _fibonacciNumbers = [34, 55, 89, 144];

  Widget _buildFibonacciRadio(int number) {
    return Radio<int>(
      value: number,
      groupValue: _selectedFibonacci,
      onChanged: (value) => {
        setState(() {
          _selectedFibonacci = value ?? 0;
        })
      },
    );
  }

  Widget _buildNumberRadio(int number) {
    return Radio<int>(
      value: number,
      groupValue: _selectedNumber,
      onChanged: (value) => {
        setState(() {
          _selectedNumber = value ?? 0;
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(114, 41, 148, 1),
        centerTitle: true,
        leading: const Text(""),
        title: const Text(
          "Eldirc",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Escolha a quantidade de pecas do jogo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Dogica Pixel",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.separated(
                        itemCount: _fibonacciNumbers.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Column(
                              children: [
                                _buildFibonacciRadio(_fibonacciNumbers[index]),
                                Text("${_fibonacciNumbers[index]}")
                              ],
                            ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Escolha um número de 1 a 8:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Dogica Pixel",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.separated(
                        itemCount: 9,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => index > 0
                            ? Column(
                                children: [
                                  _buildNumberRadio(index),
                                  Text("$index")
                                ],
                              )
                            : const SizedBox.shrink(),
                        separatorBuilder: (context, index) => index > 0
                            ? SizedBox(width: 10)
                            : SizedBox.shrink()),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromRGBO(114, 41, 148, 1),
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              onPressed: () {
                if (_selectedFibonacci < 1 || _selectedNumber < 1) {
                  const snackBar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      "Escolha um numero de pecas e um numero a ser tirado por rodada",
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Game(p: _selectedFibonacci, pMax: _selectedNumber),
                    ),
                  );
                  print('Fibonacci selecionado: $_selectedFibonacci');
                  print('Número selecionado: $_selectedNumber');
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enviar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Dogica Pixel",
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
