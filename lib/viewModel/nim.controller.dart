import 'dart:io';
import 'package:nim/model/nim.model.dart';

class NimGameController {
  late NimGameModel _model;

  NimGameController(int p, int pMax, int turno) {
    _model = NimGameModel(p, pMax, turno);
  }

  void iniciarJogo() {
    print('Seja bem-vindo ao NIM');
    print('=' * 30);

    while (_model.p > 0) {
      if (_model.turno == 1) {
        int jogada = usuarioEscolheJogada(_model.p, _model.pMax);
        _model.p -= jogada;
        print('Você retirou $jogada peças.');
      } else {
        int jogada = computadorEscolheJogada(_model.p, _model.pMax);
        _model.p -= jogada;
        print('O computador retirou $jogada peças.');
      }

      print('Sobram ${_model.p} peças.');
      _model.turno = _model.turno == 1 ? 0 : 1;
    }

    if (_model.turno == 1) {
      print('Você Venceu!!!');
    } else {
      print('O computador Venceu!!!');
    }
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

  int usuarioEscolheJogada(int p, int pMax) {
    int jogada = 0;
    while (jogada <= 0 || jogada > pMax || jogada > p) {
      stdout.write('Quantas peças você deseja retirar (1 a $pMax)? ');
      jogada = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
      if (jogada <= 0 || jogada > pMax || jogada > p) {
        print('Jogada inválida. Tente novamente.');
      }
    }
    return jogada;
  }
}
