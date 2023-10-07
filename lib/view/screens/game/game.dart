import 'package:flutter/material.dart';
import 'package:nim/viewModel/nim.controller.dart';

class Game extends StatefulWidget {
  final int p;
  final int pMax;

  const Game({super.key, required this.p, required this.pMax});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late NimGameController _gameController;
  late List<int> _gridItems;
  int _selectedNumber = 0;
  String _selectedNumberKing = "";
  final bool _shouldDelayRendering = true;

  Widget _buildNumberRadio(int number) {
    return Radio<int>(
      value: number,
      groupValue: _selectedNumber,
      onChanged: (value) {
        if (value! <= _gameController.valueP) {
          setState(() {
            _selectedNumber = value;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _gameController = NimGameController(widget.p, widget.pMax);
    _gridItems =
        List.generate(widget.p, (index) => index + 1).reversed.toList();
    _gameController.iniciarJogo();
  }

  void _removeItem(int value) {
    if (_gridItems.length < value) {
      int result = _gameController.winnerController();
      if (result == 1) {
        print("GG");
      } else {
        print("perdeu");
      }
    }
    if (_gameController.isTurnUser) {
      _gameController.usuarioEscolheJogada(value);
      setState(() {
        _gridItems.removeRange(0, value);
      });
    } else {
      int computerMove = _gameController.jogadaComputador();
      setState(() {
        _selectedNumberKing = computerMove.toString();
        _gridItems.removeRange(0, computerMove);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(114, 41, 148, 1),
        centerTitle: true,
        title: const Text(
          "Eldirc",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_gameController.turno == 0 ? "King" : "Voce"),
                const SizedBox(height: 20),
                SizedBox(
                  height: 285,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                    ),
                    itemCount: _gridItems.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        child: Card(
                          child: Center(
                            child: Text(_gridItems[index].toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Visibility(
                  visible: _gameController.isTurnUser,
                  child: Column(
                    children: [
                      const Text(
                        "Escolha a quantidade que deseja retirar!",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 64,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) =>
                              index > 0 && index <= _gameController.valueP
                                  ? Column(
                                      children: [
                                        _buildNumberRadio(index),
                                        Text("$index")
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                          separatorBuilder: (ctx, index) => index > 0
                              ? const SizedBox(width: 10)
                              : const SizedBox.shrink(),
                          itemCount: widget.pMax + 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _gameController.isTurnComputer,
                  child: Text(
                    "Valor retirado pelo rei: ${_selectedNumberKing}",
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 20),
                    ),
                    backgroundColor: _gameController.isTurnComputer
                        ? const MaterialStatePropertyAll(Colors.red)
                        : const MaterialStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () => _removeItem(_selectedNumber),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _gameController.isTurnComputer ? "Oponente" : "Retirar",
                        style: const TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
