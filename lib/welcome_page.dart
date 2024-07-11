import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Users App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,

      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
          child:
        Column(
          children: [
            Image.asset(
              'assets/github.png', // Replace with your image asset path
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
              fit: BoxFit.cover, // Adjust the fit as needed

            ),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Check out Users'),
            ),
          ],
        ),
      ),
    );
  }
}
