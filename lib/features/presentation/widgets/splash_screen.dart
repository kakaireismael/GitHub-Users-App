// lib/features/presentation/widgets/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:githubusers/features/presentation/screens/welcome_page.dart';
import 'package:githubusers/features/presentation/widgets/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
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
                'GitHub Users',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15), // Add spacing between texts
              Text(
                'Connecting Developers!',
                style: TextStyle(
                  fontSize: 16,
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