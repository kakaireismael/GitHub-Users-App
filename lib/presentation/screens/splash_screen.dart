import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_page.dart';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const WelcomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GitHub Users App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5), // Add spacing between texts
              Text(
                'Connecting Developers!',
                style: TextStyle(
                  fontSize: 16, fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))

              )
            ],
          ),
        ),
      ),
    );
  }
}