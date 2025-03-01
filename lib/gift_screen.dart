import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key});

  @override
  _GiftScreenState createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> with SingleTickerProviderStateMixin {
  bool _opened = false;
  final Random _random = Random();
  late ConfettiController _confettiController;
  late AnimationController _starController;
  late List<Offset> _starPositions;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));

    // Animation for twinkling stars
    _starController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // Generate more stars for a magical effect
    _starPositions = List.generate(100, (index) => Offset(
      _random.nextDouble() * 400,  // Random X position
      _random.nextDouble() * 800,  // Random Y position
    ));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Soft Pink Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.shade100, // Lightest pink
                  Colors.pink.shade200,
                  Colors.pink.shade300, // Soft medium pink
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Twinkling Stars ✨
          AnimatedBuilder(
            animation: _starController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarPainter(_starPositions, _starController.value),
                child: Container(),
              );
            },
          ),

          // Confetti Effect 🎊
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              colors: [Colors.red, Colors.yellow, Colors.blue, Colors.green],
              numberOfParticles: 30,
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _opened = !_opened;
                      if (_opened) _confettiController.play();
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: _opened
                        ? Icon(Icons.cake_rounded, size: 150, color: Colors.white, key: ValueKey('cake'))
                        : _buildGlowingGiftIcon(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _opened
                      ? "Happy Birthday Khansa! 🎉\nMay Allah bless you with endless happiness, \ngood health, and success in both worlds. Ameen. 🤲"
                      : "Tap to Open!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.black38, blurRadius: 8),
                      Shadow(color: Colors.pinkAccent.shade400, blurRadius: 10),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Back to Homepage Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Smaller button
                    backgroundColor: Colors.pink.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    "Keep Shining, Go Back! 💖",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎁 Glowing Gift Icon Effect
  Widget _buildGlowingGiftIcon() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.9, end: 1.1),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Icon(Icons.card_giftcard, size: 150, color: Colors.white, key: ValueKey('gift')),
        );
      },
    );
  }
}

// ✨ Custom Painter for Stars in the Background
class StarPainter extends CustomPainter {
  final List<Offset> starPositions;
  final double opacity;

  StarPainter(this.starPositions, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint starPaint = Paint()..color = Colors.white.withOpacity(opacity);
    for (var position in starPositions) {
      canvas.drawCircle(position, 2, starPaint); // Small white circles as stars
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
