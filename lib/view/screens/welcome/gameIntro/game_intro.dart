import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class GameIntroScreen extends StatefulWidget {
  const GameIntroScreen({super.key});
  @override
  _GameIntroScreenState createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen> {
  List<String> textSegments = [
    "Um reino construido sob a sombra majestosa de castelos antigos e calorosas tavernas acolhedoras, Eldric permanecia como uma terra encantada, onde cada pedra tinha uma história a contar e cada brisa carregava murmúrios de magia ancestral. Sob o reinado sábio e nobre do senhor da terra, o reino florescia, como uma tapeçaria viva de cores e sons.",
    "Sob um céu estrelado, o rei de Eldric convocou seu povo em uma noite sagrada, anunciando um torneio de inteligência e astúcia que moldaria o destino do reino. Com palavras sábias, ele guiou seus súditos para uma jornada de descobertas, onde a magia do jogo revelaria não apenas habilidades, mas também os tesouros ocultos nos corações de todos.",
    "Após o anúncio do rei, uma onda de excitação varreu as ruas de Eldric como um vendaval de alegria. À medida que a notícia do torneio se espalhava, as tabernas ressoavam com risos contagiantes e canções festivas. Os artesãos esculpiam ornamentos especiais em honra ao evento, e os cozinheiros preparavam banquetes elaborados para celebrar a ocasião. Nas praças, dançarinos treinavam passos especiais enquanto músicos afinavam seus instrumentos, todos ansiosos para participar da atmosfera festiva que se aproximava.",
    "Desencadeando pela inscerteza uma pergunta silenciosa que ecoava em todos os cantos da festividade: quem seria capaz de vencer o tão aguardado torneio? Um véu de incerteza envolvia Eldric, enquanto as pessoas se perguntavam quem, dentre eles ou o recém-chegado, emergiria como o verdadeiro herói da jornada que estava prestes a começar.",
  ];

  List<String> imageAssets = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
  ];

  int currentSegmentIndex = 0;
  bool showNextButton = false;

  @override
  void didUpdateWidget(GameIntroScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget != oldWidget) {
      setState(() {
        showNextButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset(imageAssets[currentSegmentIndex], fit: BoxFit.cover),
            Positioned(
              bottom: 20,
              child: SizedBox(
                height: 300,
                width: width * .9,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(textSegments[currentSegmentIndex],
                        textStyle: const TextStyle(fontSize: 14.0, color: Colors.white),
                        speed: const Duration(milliseconds: 100),)
                        ],
                        key: ValueKey<int>(currentSegmentIndex), 
                        repeatForever: false,
                        isRepeatingAnimation: false,
                        onFinished: () => {
                          setState(() {
                            showNextButton = true;
                          })
                        },                        
                      ),
                      if (showNextButton)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (currentSegmentIndex < textSegments.length - 1) {
                                  setState(() {
                                    showNextButton = false;
                                    currentSegmentIndex++;
                                  });
                                } else {
                                  print("Todos os segmentos de texto foram mostrados!");
                                }
                              },
                              child: const Text(
                                "Próximo",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
