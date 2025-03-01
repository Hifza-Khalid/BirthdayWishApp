import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'gift_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  final Random _random = Random();
  late List<AnimationController> _starControllers;
  late List<Animation<double>> _starAnimations;
  final int _starCount = 50; // ⭐ Number of stars

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));

    // Start the confetti effect when the screen appears
    Future.delayed(Duration(milliseconds: 500), () {
      _confettiController.play();
    });

    // ⭐ Initialize twinkling stars
    _starControllers = List.generate(_starCount, (index) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _random.nextInt(2000) + 1000),
      )..repeat(reverse: true);
    });

    _starAnimations = _starControllers.map((controller) {
      return Tween<double>(begin: 0.2, end: 1.0).animate(controller);
    }).toList();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    for (var controller in _starControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🎀 Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.pink.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // ✨ Twinkling Stars
          ..._buildStars(),

          // ✨ Confetti for Sparkles
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // Upward
              colors: [Colors.pink, Colors.white, Colors.red],
              gravity: 0.3,
            ),
          ),

          // 🎀 Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Happy Birthday! 🎂🎈",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.pink.shade700,
                    shadows: [Shadow(color: Colors.black26, blurRadius: 5)],
                  ),
                ),
                SizedBox(height: 15),

                // 📅 Date Display
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade300,
                        blurRadius: 15,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, size: 32, color: Colors.pink.shade800),
                      SizedBox(height: 5),
                      Text(
                        "Feb 28, 2025",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),

                // 💌 Birthday Wishes
                _buildWishCard("Wishing you a day full of love & laughter! 💖"),
                _buildWishCard("May this year bring happiness & success! 🎊"),
                _buildWishCard("You're a blessing! Enjoy your special day! ✨"),
                _buildWishCard("May your life be filled with joy and love! 🌸"),

                SizedBox(height: 25),

                // 🎂 Cake Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GiftScreen()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cake, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        "Open Gift 🎁",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 💌 Wish Card with Sparkle Effect
  Widget _buildWishCard(String message) {
    return GestureDetector(
      onTap: () {
        _confettiController.play(); // 🎉 Sparkles when tapped
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.pink.shade800),
          ),
        ),
      ),
    );
  }

  // 🌟 Generate Random Stars
  List<Widget> _buildStars() {
    return List.generate(_starCount, (index) {
      double left = _random.nextDouble() * MediaQuery.of(context).size.width;
      double top = _random.nextDouble() * MediaQuery.of(context).size.height;
      double size = _random.nextDouble() * 4 + 2; // Star size between 2-6 pixels

      return Positioned(
        left: left,
        top: top,
        child: FadeTransition(
          opacity: _starAnimations[index],
          child: Icon(
            Icons.star,
            color: Colors.white.withOpacity(0.8),
            size: size,
          ),
        ),
      );
    });
  }
}
