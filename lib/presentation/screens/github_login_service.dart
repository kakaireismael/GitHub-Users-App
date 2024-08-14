import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class GitHubLoginService {
  static const String clientId = 'YOUR_CLIENT_ID';
  static const String clientSecret = 'YOUR_CLIENT_SECRET';
  static const String redirectUri = 'YOUR_REDIRECT_URI'; // e.g., http://localhost:3000/auth/callback
  static const String authorizationUrl = 'https://github.com/login/oauth/authorize';
  static const String tokenUrl = 'https://github.com/login/oauth/access_token';
  static const String userProfileUrl = 'https://api.github.com/user';

  Future<String?> authenticate() async {
    try {
      final url =
          '$authorizationUrl?client_id=$clientId&redirect_uri=$redirectUri&scope=user';

      // Launch web view for the user to log in and authorize your app
      final result = await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: 'http',
      );

      // Extract the authorization code from the result
      final code = Uri.parse(result).queryParameters['code'];

      if (code != null) {
        // Exchange the authorization code for an access token
        final token = await _fetchAccessToken(code);
        return token;
      }
    } catch (e) {
      print('Error during GitHub login: $e');
    }
    return null;
  }

  Future<String?> _fetchAccessToken(String code) async {
    try {
      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      if (response.statusCode == 200) {
        final tokenResponse = jsonDecode(response.body);
        return tokenResponse['access_token'];
      }
    } catch (e) {
      print('Error fetching access token: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchGitHubUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse(userProfileUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }
}
