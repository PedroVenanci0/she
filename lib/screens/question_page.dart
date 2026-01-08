import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'details_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with SingleTickerProviderStateMixin {
  // Audio
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  
  // Confetti
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 10));

  late AnimationController _backgroundController;
  // State
  bool _noTransformed = false; // Controla se o botão NÃO virou SIM
  bool _showCelebration = false;
  bool _showPhotos = false;

  // Lista de Figurinhas
  final List<String> _stickerAssets = [
    'assets/images/foto_01.png',
    'assets/images/foto_02.png',
    'assets/images/foto_03.png',
    'assets/images/foto_04.png',
    'assets/images/foto_05.png',
    'assets/images/foto_06.png',
    'assets/images/foto_07.png',
    'assets/images/foto_09.png',
    'assets/images/less.png',
    'assets/images/potter.png',
  ];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    // _playRomanticMusic();
  }

      debugPrint("Erro ao tocar audio: $e");
    } */
  }

  Path drawHeart(Size size) {
    final path = Path();
    path.moveTo(0.5 * size.width, size.height * 0.35);
    path.cubicTo(0.2 * size.width, size.height * 0.1, -0.25 * size.width, size.height * 0.6, 0.5 * size.width, size.height);
    path.cubicTo(1.25 * size.width, size.height * 0.6, 0.8 * size.width, size.height * 0.1, 0.5 * size.width, size.height * 0.35);
    path.close();
    return path;
  }

  void _celebrate() async {
    setState(() {
      _showCelebration = true;
    });
    _confettiController.play();
    
    /* // Tocar a música especial "Varinha de Condão"
    try {
      await _audioPlayer.stop(); // Para a música anterior
      // Tenta tocar. 
      await _audioPlayer.play(AssetSource('audio/varinha_de_condao.mp3'));
      await _audioPlayer.setVolume(0.2); // Volume baixo como pedido
    } catch (e) {
      debugPrint("Erro ao tocar música final: $e");
    } */

    // Wait a bit to appreciate, then navigate
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
        // _audioPlayer.stop(); // REMOVIDO: A música continua tocando enquanto vai para a próxima tela
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const DetailsPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1500), // Transição suave de 1.5s
          ),
        );
    }
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Warm paper white
      body: Stack(
        children: [
          // 1. Background Hearts
          Positioned.fill(child: CustomPaint(painter: _HeartBackgroundPainter(animation: _backgroundController))),

          // 3. Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Typewriter Message Card (Paper Style)
                      FadeIn(
                        duration: const Duration(seconds: 2),
                        child: Container(
                            width: size.width > 600 ? 550 : size.width * 0.9,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1), 
                                  blurRadius: 15,
                                  offset: const Offset(0, 5)
                                )
                              ],
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date-like header
                                Text(
                                  "Para: Ana Leticia",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[600]
                                  ),
                                ),
                                const Divider(color: Colors.black12, height: 30),
                                
                                DefaultTextStyle(
                                  style: GoogleFonts.lora( // Elegant Serif for body
                                    fontSize: 18, 
                                    color: const Color(0xFF2C2C2C),
                                    height: 1.6,
                                  ),
                                  child: AnimatedTextKit(
                                    totalRepeatCount: 1,
                                    displayFullTextOnTap: true,
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        "Oii ana leticia,\n\nBom, venho por meio desse humilde site lhe chamar para sair comigo. Assim, vc sabe que eu adoro conversar com vc, mas seria ainda melhor pessoalmente...\n\nPor isso eu te pergunto:",
                                        speed: const Duration(milliseconds: 50),
                                        cursor: '❤️',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),

                      // ACtion Card (Minimalist)
                      ZoomIn(
                        delay: const Duration(seconds: 4), 
                        child: Column(
                          children: [
                            Text(
                              "Aceita sair comigo?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay( // Premium Title Font
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF8B0000), // Deep Red
                              ),
                            ),
                            const SizedBox(height: 30),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SIM - Elegant Button
                                ElevatedButton(
                                  onPressed: _celebrate,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B0000), // Deep Red
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), // Sharper corners for elegance
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    "SIM", 
                                    style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold)
                                  ),
                                ),
                                
                                const SizedBox(width: 20), // Manual gap just in case

                                // NÃO -> Vira SIM
                                MouseRegion(
                                  onEnter: (_) => setState(() => _noTransformed = true), // Transforma ao passar o mouse
                                  child: _noTransformed
                                      ? ElevatedButton(
                                          onPressed: _celebrate, // Se já virou SIM, celebra
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF8B0000),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            elevation: 2,
                                          ),
                                          child: Text(
                                            "SIM", 
                                            style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold)
                                          ),
                                        )
                                      : OutlinedButton(
                                          onPressed: () => setState(() => _noTransformed = true), // Primeiro clique apenas transforma
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: const Color(0xFF8B0000),
                                            side: const BorderSide(color: Color(0xFF8B0000)),
                                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          ),
                                          child: Text(
                                            "NÃO", 
                                            style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // 6. Confetti Overlay
           Align(
             alignment: Alignment.topCenter,
             child: ConfettiWidget(
               confettiController: _confettiController,
               blastDirectionality: BlastDirectionality.explosive,
               shouldLoop: false,
               colors: const [Colors.red, Colors.pink, Colors.purple, Colors.deepOrange],
               createParticlePath: drawHeart,
             ),
           ),

           // 7. Stickers Explosion (Figurinhas)
           if (_showCelebration)
             ..._stickerAssets.map((asset) => FloatingSticker(asset: asset, screenSize: size)),
        ],
      ),
    );
  }

}

class _HeartBackgroundPainter extends CustomPainter {
  final Animation<double> animation;

  _HeartBackgroundPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = Random(42);
    for (int i = 0; i < 40; i++) {
      double x = random.nextDouble() * size.width;
      double initialY = random.nextDouble() * size.height;
      double s = random.nextDouble() * 20 + 10;
      double speed = 0.5 + random.nextDouble();

      double travel = animation.value * size.height * speed;
      double h = size.height + 100;
      double y = (initialY - travel) % h;
      if (y < 0) y += h;
      y -= 50;
      
      Path path = Path();
      path.moveTo(x, y + s / 4);
      path.cubicTo(x, y, x - s / 2, y, x - s / 2, y + s / 4);
      path.cubicTo(x - s / 2, y + s / 2, x, y + s, x, y + s);
      path.cubicTo(x, y + s, x + s / 2, y + s / 2, x + s / 2, y + s / 4);
      path.cubicTo(x + s / 2, y, x, y, x, y + s / 4);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingSticker extends StatefulWidget {
  final String asset;
  final Size screenSize;

  const FloatingSticker({super.key, required this.asset, required this.screenSize});

  @override
  State<FloatingSticker> createState() => _FloatingStickerState();
}

class _FloatingStickerState extends State<FloatingSticker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _angle;
  late double _distance;
  late double _rotation;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Player individual para cada figurinha

  @override
  void initState() {
    super.initState();
    final random = Random();
    _angle = random.nextDouble() * 2 * pi; // Direção aleatória (360 graus)
    // Aumentando a distância para espalhar mais (foi de 100-350 para 200-600)
    _distance = 200 + random.nextDouble() * 400; 
    // Rotação muito mais agressiva (entre -2 e 2 voltas completas aleatórias)
    _rotation = (random.nextDouble() - 0.5) * 4 * pi;
    
    _playPopSound(); // Toca o som assim que a figurinha aparece
    
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500 + random.nextInt(1000)));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart);
    
    _controller.forward();
  }

  void _playPopSound() async {
    try {
      // Variação de pitch (0.8 a 1.4) para parecer sons diferentes
      // Isso faz com que cada "pop" soe único e divertido
      // double pitch = 0.8 + Random().nextDouble() * 0.6;
      
      // await _audioPlayer.setSource(AssetSource('musicas/pop.mp3'));
      // await _audioPlayer.setPlaybackRate(pitch); // Muda a "voz" do som
      // await _audioPlayer.setVolume(0.3); // Volume agradável para não assustar
      // await _audioPlayer.resume();
    } catch (e) {
      // Ignora erro caso o arquivo ainda não tenha sido carregado
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final val = _animation.value;
        // Começa do centro e vai para fora
        final dx = cos(_angle) * _distance * val;
        final dy = sin(_angle) * _distance * val;
        
        // Posição inicial (Centro da tela) + Deslocamento
        final startX = widget.screenSize.width / 2 - 50; // -50 para centralizar a imagem de 100px
        final startY = widget.screenSize.height / 2 - 50;

        return Positioned(
          left: startX + dx,
          top: startY + dy,
          child: Transform.rotate(
            angle: _rotation * val * 5, // Gira enquanto voa
            child: Opacity(
              opacity: 1.0 - (val * 0.1), // Mantém visível
              child: Image.asset(
                widget.asset, 
                width: 100, 
                height: 100,
                errorBuilder: (context, error, stackTrace) => const SizedBox(), // Se não achar, não quebra
              ),
            ),
          ),
        );
      },
    );
  }
}
