import 'package:flutter/material.dart';
import 'package:nim/model/nim.model.dart';

class NimGameController {
  late NimGameModel _model;
  late int turno;
  bool get isTurnComputer => turno == 0;
  bool get isTurnUser => turno == 1;
  int get valueP => _model.p;
  NimGameController(int p, int pMax) {
    _model = NimGameModel(p, pMax);
  }

  void iniciarJogo() {
    _model.partida();
    turno = _model.turno;
  }

  int winnerController() {
    if (_model.p == 0) {
      return _model.getWinner();
    } else {
      throw ("Ainda tem pecas");
    }
  }

  void realizarJogada(int quantidade) {
    if (_model.p <= 0) {
      throw ('Jogo já acabou.');
    }
    if (turno == 0) {
      jogadaComputador();
    } else {
      usuarioEscolheJogada(quantidade);
    }
  }

  int jogadaComputador() {
    if (isTurnComputer) {
      int jogada = computadorEscolheJogada(_model.p, _model.pMax);
      _model.p -= jogada;
      print('O computador retirou $jogada peças.');
      turno = 1;
    }
    return computadorEscolheJogada(_model.p, _model.pMax);
  }

  int computadorEscolheJogada(int p, int pMax) {
    int jogada = 1;
    if (p > pMax) {
      jogada = (p - 1) % (pMax + 1);
      if (jogada == 0) {
        jogada = pMax;
      }
    }
    return jogada;
  }

  void usuarioEscolheJogada(int value) {
    if (isTurnUser) {
      int jogada = value;
      if (jogada <= 0 || jogada > _model.pMax || jogada > _model.p) {
        throw ('Jogada inválida. Tente novamente.');
      }
      _model.p -= jogada;
      print('O jogador retirou $jogada peças.');
      turno = 0;
      print(_model.p);
    }
  }

  void Error(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
