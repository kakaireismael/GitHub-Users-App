import 'package:flutter/material.dart';
import 'package:github_users_app/presentation/screens/homepage.dart';
import 'package:github_users_app/presentation/screens/login_screen_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to GitHub Users App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                const Text(
                  'Browse users and their profiles.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 150),
                Image.asset(
                  'assets/github.png', // Replace with your image asset path
                  width: 80, // Adjust the width as needed
                  height: 80, // Adjust the height as needed
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Changed color to white for better contrast
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
