class NimGameModel {
  int p;
  int pMax;
  late int turno;

  void partida() {
    if (p % (pMax + 1) == 0 && pMax == 1) {
      print('Computador Começa');
      turno = 0;
    } else if ((pMax + 1) == p) {
      print('Computador Começa');
      turno = 0;
    } else if (p % (pMax + 1) == 0) {
      print('Você Começa');
      turno = 1;
    } else {
      print('Você começa');
      turno = 1;
    }
  }

  int getWinner() {
    if (turno == 1) {
      print('Você Venceu!!!');
      return 1;
    } else {
      print('O computador Venceu!!!');
      return 0;
    }
  }

  NimGameModel(this.p, this.pMax);
}
