import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> generateStars(int count) {
    final Random random = Random();
    return List.generate(count, (index) {
      double size = random.nextDouble() * 6 + 4; // Star size between 4-10 pixels
      double left = random.nextDouble() * MediaQuery.of(context).size.width;
      double top = random.nextDouble() * MediaQuery.of(context).size.height;

      return Positioned(
        left: left,
        top: top,
        child: FadeTransition(
          opacity: Tween(begin: 0.3, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Icon(Icons.star, color: Colors.white, size: size),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFC1E3), // Light Pink
                  Color(0xFFFF69B4), // Hot Pink
                  Color(0xFFD81B60), // Dark Pink
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ...generateStars(20), // Generate 20 random stars
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cake.gif', width: 200),
                SizedBox(height: 20),
                Text(
                  "Happy Birthday Khansa! 🎉",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(color: Colors.black38, blurRadius: 8),
                      Shadow(color: Colors.pinkAccent.shade700, blurRadius: 12),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
