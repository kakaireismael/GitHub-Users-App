import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'user_profile.dart';
import 'userlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,; initialRoute: '/', // Set initial route to '/'
  routes: {
    '/': (context) => const WelcomePage(), // Map '/' route to FirstPage
    '/second': (context) => const Homepage(), // Map '/second' route to SecondPage
    };
      );
  }
}

