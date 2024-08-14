import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class GitHubLoginPage extends StatefulWidget {
  @override
  _GitHubLoginPageState createState() => _GitHubLoginPageState();
}

class _GitHubLoginPageState extends State<GitHubLoginPage> {
  String? _accessToken;
  String? _username;

  // Replace with your GitHub OAuth app details
  final String clientId = 'YOUR_CLIENT_ID';
  final String clientSecret = 'YOUR_CLIENT_SECRET';
  final String redirectUri = 'yourapp://callback';

  Future<void> _loginWithGitHub() async {
    // Generate the authorization URL
    final url =
        'https://github.com/login/oauth/authorize?client_id=$clientId&scope=read:user,user:email';

    // Trigger the web authentication
    final result = await FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: 'yourapp',
    );

    // Extract the code from the callback URL
    final code = Uri.parse(result).queryParameters['code'];

    // Request the access token from GitHub
    final response = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: {'Accept': 'application/json'},
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    final responseBody = json.decode(response.body);
    final accessToken = responseBody['access_token'];

    setState(() {
      _accessToken = accessToken;
    });

    // Fetch the GitHub user's profile
    final userResponse = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    final user = json.decode(userResponse.body);
    setState(() {
      _username = user['login'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Login'),
      ),
      body: Center(
        child: _accessToken == null
            ? ElevatedButton(
          onPressed: _loginWithGitHub,
          child: const Text('Login with GitHub'),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Logged in successfully'),
            Text('Username: $_username'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _accessToken = null;
                  _username = null;
                });
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
