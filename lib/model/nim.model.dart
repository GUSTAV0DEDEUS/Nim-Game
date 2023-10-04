import 'dart:io';

void main() {
  print('Seja bem-vindo ao NIM');
  print('=' * 30);

  int p = lerQuantidadePecas('Digite a quantidade de peças: ');
  int pMax = lerQuantidadePecas(
      'Digite a quantidade máxima de peças a ser retirada por rodada: ', p);

  int turno = partida(p, pMax);
  while (p > 0) {
    if (turno == 1) {
      int jogada = usuario_escolhe_jogada(p, pMax);
      p -= jogada;
      print('Você retirou $jogada peças.');
    } else {
      int jogada = computador_escolhe_jogada(p, pMax);
      p -= jogada;
      print('O computador retirou $jogada peças.');
    }

    print('Sobram $p peças.');
    turno = turno == 1 ? 0 : 1;
  }

  if (turno == 1) {
    print('Você Venceu!!!');
  } else {
    print('O computador Venceu!!!');
  }
}

int lerQuantidadePecas(String mensagem, [int p = 1000]) {
  stdout.write(mensagem);
  int? quantidade = int.tryParse(stdin.readLineSync() ?? '');
  if (quantidade == null || quantidade <= 0) {
    print('Digite um valor válido.');
    return lerQuantidadePecas(mensagem);
  }
  if (quantidade >= p) {
    print('Digite um valor menor que a quantidade de peças!!');
    return lerQuantidadePecas(mensagem);
  }
  return quantidade;
}

int computador_escolhe_jogada(int p, int pMax) {
  int jogada = 1;
  if (p > pMax) {
    jogada = (p - 1) % (pMax + 1);
    if (jogada == 0) {
      jogada = pMax;
    }
  }
  return jogada;
}

int usuario_escolhe_jogada(int p, int pMax) {
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

int partida(int p, int pMax) {
  if (p % (pMax + 1) == 0 && pMax == 1) {
    print('Computador Começa');
    return 0;
  } else if ((pMax + 1) == p) {
    print('Computador Começa');
    return 0;
  } else if (p % (pMax + 1) == 0) {
    print('Você Começa');
    return 1;
  } else {
    print('Você começa');
    return 1;
  }
}
