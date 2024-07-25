import 'package:flutter/material.dart';
import 'package:githubusers/features/presentation/screens/homepage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
            'Welcome to GitHub Users App',
        style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.blue

        )),

            const SizedBox(height: 150),
            Image.asset(
              'assets/github.png', // Replace with your image asset path
              width: 120, // Adjust the width as needed
              height: 120, // Adjust the height as needed
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
              child: const Text(
                  'GET STARTED',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue
              ),
            ),
            ),
        ],
      ),
      )
    );
  }
}
