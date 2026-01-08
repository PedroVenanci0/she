import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:encontro_perfeito/screens/question_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  void _login() async {
    setState(() => _isLoading = true);
    
    // Simulate a small delay for dramatic effect
    await Future.delayed(const Duration(seconds: 1));

    String nick = _nicknameController.text.trim().toLowerCase();
    String pass = _passwordController.text.trim().toLowerCase();

    // Validation (relaxed checking for nick)
    if (nick.contains("ana") && nick.contains("leticia") && pass == "cuscuz") {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const QuestionPage()),
        );
    } else {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Ops! Senha incorreta... Você não é a Cuscuz (eu acho)! Tente de novo 🤭", 
            style: GoogleFonts.nunito()
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Warm Paper
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: HeartBackgroundPainter(animation: _controller))),
          Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(8), // Borda branca estilo figurinha
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xFFFFF0F5), // Fundo suave
                    child: ClipOval(
                      child: Image.asset(
                        'assets/she/ela.jpeg',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  "O Melhor Site do Mundo",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
              ),
               FadeInDown(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  "Este site pertence inteiramente a você.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Inputs Card
              ZoomIn(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                    border: Border.all(color: Colors.grey.shade200)
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nicknameController, 
                        label: "Identificação", 
                        icon: Icons.person_outline
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _passwordController, 
                        label: "Senha", 
                        icon: Icons.key_outlined,
                        isPassword: true
                      ),
                      const SizedBox(height: 30),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B0000), // Deep Red
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            elevation: 0,
                          ),
                          child: _isLoading 
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text(
                                "ENTRAR", 
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2
                                )
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller, 
    required String label, 
    required IconData icon,
    bool isPassword = false
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: const Color(0xFF8B0000),
      style: GoogleFonts.lora(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lora(color: Colors.grey[700]),
        prefixIcon: Icon(icon, color: Colors.grey[600], size: 20),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF8B0000), width: 2),
        ),
        filled: false,
      ),
    );
  }
}

class HeartBackgroundPainter extends CustomPainter {
  final Animation<double> animation;

  HeartBackgroundPainter({required this.animation}) : super(repaint: animation);

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
      double speed = 0.5 + random.nextDouble(); // Velocidade variada para cada coração

      // Lógica de movimento: sobe e reinicia embaixo
      double travel = animation.value * size.height * speed;
      double h = size.height + 100; // Altura total + margem
      double y = (initialY - travel) % h;
      if (y < 0) y += h; // Garante que o valor seja positivo
      y -= 50; // Ajuste para começar um pouco fora da tela
      
      Path path = Path();
      // Desenho simples de coração
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
