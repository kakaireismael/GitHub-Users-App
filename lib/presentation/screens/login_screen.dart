import 'package:flutter/material.dart';
import 'package:github_users_app/presentation/screens/github_login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with GitHub'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _loginWithGitHub,
              child: const Text('Login with GitHub'),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithGitHub() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final githubLoginService = GitHubLoginService();
    final accessToken = await githubLoginService.authenticate();

    if (accessToken != null) {
      // Fetch the GitHub user profile
      final userProfile = await githubLoginService.fetchGitHubUserProfile(accessToken);

      // Navigate to the next page if the login is successful
      if (userProfile != null) {
        Navigator.pushReplacementNamed(context, '/home', arguments: userProfile);
      } else {
        setState(() {
          errorMessage = 'Error fetching user profile';
        });
      }
    } else {
      setState(() {
        errorMessage = 'Login failed';
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
