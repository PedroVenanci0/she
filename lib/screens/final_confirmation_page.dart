
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

// Reusing sticker logic from QuestionPage for consistency, but simpler
class FinalConfirmationPage extends StatefulWidget {
  final bool acceptedBK;

  const FinalConfirmationPage({super.key, required this.acceptedBK});

  @override
  State<FinalConfirmationPage> createState() => _FinalConfirmationPageState();
}

class _FinalConfirmationPageState extends State<FinalConfirmationPage> {
  late ConfettiController _confettiController;
  
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
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    // Start confetti and stickers immediately
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    // Replace with your actual number or a placeholder
    final decisionText = widget.acceptedBK 
        ? "ACEITO o Date Oficial no Myko e TAMBÉM o Pré-Date no BK! 🍔❤️" 
        : "ACEITO o Date Oficial no Myko, mas o BK fica pra próxima... ❤️";
        
    final Uri url = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(decisionText)}");
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
       // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: Stack(
        children: [
          // 1. Stickers Background (Fixed position or somewhat chaotic)
          // We reusing the logic from QuestionPage but ensuring they don't block text too much
          // Actually, let's just use specific positions or random
          ...List.generate(_stickerAssets.length, (index) {
             return _ChaoticSticker(asset: _stickerAssets[index], screenSize: size);
          }),

          // 2. Confetti
           Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              colors: const [Colors.red, Colors.orange, Colors.pink, Colors.purple],
            ),
          ),

          // 3. Main Content Card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: FadeInUp(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95), // Semi-transparent for stickers behind? No, opaque for readability
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10)
                      )
                    ],
                    border: Border.all(color: Colors.pink.shade100, width: 2)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite, size: 60, color: Color(0xFF8B0000)),
                      const SizedBox(height: 20),
                      Text(
                        "Resumo do Crime",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28, 
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C2C2C)
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      
                      // Myko Confirmation
                      _buildSummaryRow(
                        "Date Oficial (Myko)", 
                        true, 
                        "Confirmadíssimo! Sábado, 17h."
                      ),
                      const Divider(height: 30),
                      
                      // BK Confirmation
                      _buildSummaryRow(
                        "Pré-Date (BK)", 
                        widget.acceptedBK, 
                        widget.acceptedBK 
                          ? "Aceito! Amanhã tem hambúrguer!" 
                          : "Recusado. (Triste, mas acontece)"
                      ),
                      
                      const SizedBox(height: 40),
                      
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.camera_alt, color: Colors.orange),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "Tire um print desta tela agora e me mande!",
                                style: GoogleFonts.lora(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      /* 
                      // Opcional: Botão de WhatsApp se ela quiser facilitar
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _launchWhatsApp,
                        icon: const Icon(Icons.send),
                        label: const Text("Enviar Resposta no Zap"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                      ) 
                      */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, bool accepted, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          accepted ? Icons.check_circle : Icons.cancel, 
          color: accepted ? Colors.green : Colors.red,
          size: 28,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(details, style: GoogleFonts.lora(fontSize: 15, color: Colors.grey[700])),
            ],
          ),
        )
      ],
    );
  }
}

class _ChaoticSticker extends StatefulWidget {
  final String asset;
  final Size screenSize;

  const _ChaoticSticker({required this.asset, required this.screenSize});

  @override
  State<_ChaoticSticker> createState() => _ChaoticStickerState();
}

class _ChaoticStickerState extends State<_ChaoticSticker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Final properties
  late double _left;
  late double _top;
  late double _rotation;
  late double _scale;

  @override
  void initState() {
    super.initState();
    final random = Random();
    
    // Random position across the screen (safely within bounds mostly)
    _left = random.nextDouble() * (widget.screenSize.width - 100);
    _top = random.nextDouble() * (widget.screenSize.height - 100);
    
    // Random rotation (-30 to 30 degrees approx)
    _rotation = (random.nextDouble() - 0.5); 
    
    // Random scale (0.8 to 1.5)
    _scale = 0.8 + random.nextDouble() * 0.7;

    _controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 600 + random.nextInt(600))
    )..forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _left,
      top: _top,
      child: ScaleTransition(
        scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        child: Transform.rotate(
          angle: _rotation,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              widget.asset, 
              width: 100 * _scale, 
              height: 100 * _scale,
              fit: BoxFit.contain,
              errorBuilder: (_,__,___) => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
