import 'package:flutter/material.dart';
import 'package:nim/viewModel/nim.controller.dart';

class Game extends StatefulWidget {
  final int p;
  final int pMax;

  const Game({Key? key, required this.p, required this.pMax}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late NimGameController _gameController;
  late List<int> _gridItems;
  int _selectedNumber = 0;

  @override
  void initState() {
    super.initState();
    _gameController = NimGameController(widget.p, widget.pMax);
    _gridItems =
        List.generate(widget.p, (index) => index + 1).reversed.toList();
    _gameController.iniciarJogo();
  }

  void _removeItem(int value) {
    try {
      if (_gameController.isTurnUser) {
        _gameController.realizarJogada(value);
        setState(() {
          _gridItems.removeRange(0, value);
          _selectedNumber = 0;
        });
      } else {
        int algo = _gameController.jogadaComputador();
        print(algo);
        setState(() {
          _selectedNumber = 0;
          _gridItems.removeRange(0, algo);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildNumberRadio(int number) {
    return Radio<int>(
      value: number,
      groupValue: _selectedNumber,
      onChanged: _gameController.isTurnUser
          ? (value) {
              setState(() {
                _selectedNumber = value!;
              });
            }
          : null,
    );
  }

  List<Widget> _buildNumberRadioButtons() {
    int maxButtons = _gameController.valueP < widget.pMax
        ? _gameController.valueP
        : widget.pMax;
    List<Widget> radioButtons = [];

    for (int i = 1; i <= maxButtons; i++) {
      radioButtons.add(
        Column(
          children: [
            _buildNumberRadio(i),
            Text("$i"),
          ],
        ),
      );
    }
    return radioButtons;
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
                Text(_gameController.isTurnComputer ? "King" : "Você"),
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
                          itemCount: _buildNumberRadioButtons().length,
                          itemBuilder: (ctx, index) =>
                              _buildNumberRadioButtons()[index],
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  isUserTurn: _gameController.isTurnUser,
                  selectedNumber: _selectedNumber,
                  onButtonPressed: _removeItem,
                  valueP: _gameController.valueP,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final bool isUserTurn;
  final int selectedNumber;
  final int valueP;
  final Function(int) onButtonPressed;
  late bool isEnabled = selectedNumber <= valueP;
  Button(
      {Key? key,
      required this.isUserTurn,
      required this.selectedNumber,
      required this.onButtonPressed,
      required this.valueP})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isUserTurn && isEnabled) {
      return buttonTheme(Colors.blue, "Retirar", false);
    } else if ((!isUserTurn) && isEnabled) {
      return buttonTheme(Colors.red, "Oponente", false);
    } else {
      return buttonTheme(Colors.black, "Escolha outro valor", true);
    }
  }

  TextButton buttonTheme(Color background, String text, bool enabled) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20),
        ),
        backgroundColor: MaterialStateProperty.all(background),
      ),
      onPressed: () => enabled ? null : onButtonPressed(selectedNumber),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}
