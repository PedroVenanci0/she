import 'package:animate_do/animate_do.dart';
import 'package:encontro_perfeito/screens/pre_encontro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  
  bool _checkBeijos = false;
  bool _checkGostoso = false;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  void _goToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PreEncontroPage()),
    );
  }

  Future<void> _openMap() async {
    // Usando uma busca genérica ou o link que o usuário forneceu (se fosse válido), 
    // mas busca por nome é mais segura
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=Myko+Coffee");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o mapa')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _checkBeijos && _checkGostoso;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Warm Paper
      appBar: AppBar(
        title: Text(
          "O Plano", 
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF2C2C2C), 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C2C2C)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _HeartBackgroundPainter(animation: _backgroundController))),
          // Conteúdo Principal
          SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // Card Estilo Convite/Menu
                FadeInDown(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(0), // Padding interno removido para a imagem encostar
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagem do Local
                        Image.asset(
                          'assets/local/myko.jpg', // Myko Coffee
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220,
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Myko Coffee",
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 28, 
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2C2C2C)
                                ),
                              ),
                              const Divider(height: 30, color: Colors.black12),
                              
                              _buildInfoRow(Icons.calendar_today_outlined, "Sábado"),
                              const SizedBox(height: 15),
                              _buildInfoRow(Icons.access_time, "17:00"),
                              const SizedBox(height: 15),
                              _buildInfoRow(Icons.directions_car_filled_outlined, "Passo na sua casa para te buscar"),
                              
                              const SizedBox(height: 20),
                              
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDFBF7),
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.info_outline, color: Color(0xFF8B0000), size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Obs: Se eu atrasar 15 min, por favor não me bata... (ficar bonito demora!)",
                                        style: GoogleFonts.lora(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey[700]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 20),
                              
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: _openMap,
                                  icon: const Icon(Icons.map_outlined, color: Color(0xFF8B0000)),
                                  label: Text("Ver Localização", style: GoogleFonts.playfairDisplay(color: const Color(0xFF8B0000), fontWeight: FontWeight.bold)),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    side: const BorderSide(color: Color(0xFF8B0000)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),

                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    "Termos de Aceite",
                    style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF2C2C2C)),
                  ),
                ),

                const SizedBox(height: 15),

                // Checkboxes Estilizados
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      _buildCustomCheckbox(
                        value: _checkBeijos,
                        text: "Estou ciente que estou sujeita a beijos inesperados.",
                        onChanged: (v) => setState(() => _checkBeijos = v!),
                      ),
                      const SizedBox(height: 10),
                      _buildCustomCheckbox(
                        value: _checkGostoso,
                        text: "Concordo que o companheiro é muito gostoso e irresistível.",
                        onChanged: (v) => setState(() => _checkGostoso = v!),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Botão Final
                FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled ? _goToHomePage : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B0000), // Deep Red
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: isButtonEnabled ? 2 : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            "CONFIRMAR",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.white,
                              letterSpacing: 1.5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFF8B0000)),
        const SizedBox(width: 15),
        Expanded(child: Text(text, style: GoogleFonts.lora(fontSize: 16, color: const Color(0xFF2C2C2C)))),
      ],
    );
  }

  Widget _buildCustomCheckbox({required bool value, required String text, required ValueChanged<bool?> onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: value ? const Color(0xFF8B0000) : Colors.grey.shade300),
        boxShadow: [
          if (value) BoxShadow(color: Colors.red.withOpacity(0.05), blurRadius: 5)
        ]
      ),
      child: CheckboxListTile(
        activeColor: const Color(0xFF8B0000),
        title: Text(text, style: GoogleFonts.lora(fontSize: 14, color: Colors.grey[800])),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
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
