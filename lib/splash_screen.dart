import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:tic_tac_toe/game_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any necessary initialization logic here
    Future.delayed(
      const Duration(seconds: 5),
      () {
        // Navigate to the next screen after the splash screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TicTacToeApp(), // Replace with your home screen
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.asset(
                  'assets/tic.json',
                  height: 200, // Adjust the height as needed
                  width: 300, // Adjust the width as needed
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tic Tac Toe",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
