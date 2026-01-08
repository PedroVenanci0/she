
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:encontro_perfeito/screens/final_confirmation_page.dart';

class PreEncontroPage extends StatefulWidget {
  const PreEncontroPage({super.key});

  @override
  State<PreEncontroPage> createState() => _PreEncontroPageState();
}

class _PreEncontroPageState extends State<PreEncontroPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Start confetti shortly after entry
    Future.delayed(const Duration(milliseconds: 500), () => _confettiController.play());
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _launchBKMap() async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=Burger+King+Frei+Serafim");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
       // handle error
    }
  }

  void _finish(bool acceptedBK) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalConfirmationPage(acceptedBK: acceptedBK)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: Stack(
        children: [
           Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              colors: const [Colors.red, Colors.orange, Colors.yellow],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    child: const Icon(Icons.lightbulb_outline, size: 80, color: Colors.amber),
                  ),
                  const SizedBox(height: 20),
                  FadeInDown(
                     delay: const Duration(milliseconds: 200),
                    child: Text(
                      "Espere um pouco...", 
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C2C2C)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeIn(
                    delay: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10)
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Text(
                              "E se a gente melhorar o plano?",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8B0000)
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Que tal um Pré-Encontro amanhã?",
                            style: GoogleFonts.lora(
                              fontSize: 18,
                              fontWeight: FontWeight.bold, 
                              color: Colors.black87
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Local: BK da Frei Serafim 🍔",
                            style: GoogleFonts.lora(fontSize: 16, color: Colors.grey[800]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Motivo: Reconhecimento de terreno (e comer, claro).",
                            style: GoogleFonts.lora(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Botão NÃO (Real)
                              TextButton(
                                onPressed: () => _finish(false),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey[600],
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                ),
                                child: const Text("Melhor não...", style: TextStyle( fontSize: 16)),
                              ),
                              const SizedBox(width: 15),
                              // Botão SIM (Topo)
                              ElevatedButton(
                                onPressed: () => _finish(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE31837), // BK Red-ish
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  elevation: 2
                                ),
                                child: const Text("TOPO!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextButton.icon(
                            onPressed: _launchBKMap,
                            icon: const Icon(Icons.map, size: 18, color: Colors.grey),
                            label: Text("Ver Localização", style: TextStyle(color: Colors.grey[700])),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
