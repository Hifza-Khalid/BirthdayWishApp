import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  const BirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy Birthday Khansa',
      theme: ThemeData(
        fontFamily: 'Pacifico',
      ),
      home: SplashScreen(),
    );
  }
}
