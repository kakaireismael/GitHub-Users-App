import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreenPage(),
    );
  }
}

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  LoginScreenPageState createState() => LoginScreenPageState();
}

class LoginScreenPageState extends State<LoginScreenPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // GitHub OAuth credentials
  final clientId = 'YOUR_GITHUB_CLIENT_ID';
  final clientSecret = 'YOUR_GITHUB_CLIENT_SECRET';
  final redirectUri = 'YOUR_REDIRECT_URI'; // e.g., http://localhost:8080/

  // Sign-in with GitHub
  Future<void> _signInWithGitHub() async {
    try {
      // Start the authentication process
      final url =
          'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=read:user%20user:email';

      final result = await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: "http", // This must match your redirect scheme
      );

      // Extract code from the result URL
      final code = Uri.parse(result).queryParameters['code'];

      // Exchange the authorization code for an access token
      final response = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code!,
          'redirect_uri': redirectUri,
        },
      );

      final accessToken = json.decode(response.body)['access_token'];

      // You can now use the access token to authenticate API requests
      print('Access token: $accessToken');

      // Example: Fetch user profile
      final userResponse = await http.get(
        Uri.parse('https://api.github.com/user'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      print('GitHub User Profile: ${userResponse.body}');
    } catch (e) {
      print('Error occurred during GitHub login: $e');
    }
  }

  // Function to navigate to GitHub sign-up page
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      throw 'Could not launch $url';
    }
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GitHub logo
              const SizedBox(height: 150),
              Image.asset(
                'assets/github_login.png', // Replace with your image asset path
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
              const SizedBox(height: 20),

              // Sign-in title
              const Text(
                'Sign in to GitHub',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),

              // Username or email input (purely UI)
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Username or email address',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  ),
                  prefixIcon: Icon(Icons.account_circle_rounded),
                ),
              ),
              const SizedBox(height: 20),

              // Password input (purely UI)
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  ),
                  prefixIcon: Icon(Icons.key_rounded),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _launchURL('https://github.com/password_reset');
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign in Button
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3), // GitHub blue
                  ),
                  onPressed: _signInWithGitHub, // Sign-in functionality
                  child: const Text(
                    'Sign in with GitHub',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Create an account option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New to GitHub?'),
                  TextButton(
                    onPressed: () {
                      _launchURL('https://github.com/signup');
                    },
                    child: const Text(
                      'Create an account',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
