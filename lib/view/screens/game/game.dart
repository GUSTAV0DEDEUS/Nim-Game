import 'package:flutter/material.dart';
import 'package:nim/viewModel/nim.controller.dart';

class Game extends StatefulWidget {
  final int p;
  final int pMax;

  Game({required this.p, required this.pMax});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late NimGameController _gameController;
  late int _piecesLeft;
  late String _result;

  @override
  void initState() {
    super.initState();
    _gameController = NimGameController(widget.p, widget.pMax);
    _piecesLeft = widget.p;
    _result = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nim Game'),
      ),
      body: Text("oi"),
    );
  }
}
