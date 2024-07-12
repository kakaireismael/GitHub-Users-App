import 'package:flutter/material.dart';
import 'package:githubusers/homepage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome to Github Users App"),

            const SizedBox(height: 150),
            Image.asset(
              'assets/github.png', // Replace with your image asset path
              width: 160, // Adjust the width as needed
              height: 160, // Adjust the height as needed
              fit: BoxFit.cover, // Adjust the fit as needed
            ),

            const SizedBox(height: 150),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('GET STARTED'),
            ),
          ],
        ),
      ),
    );
  }
}
