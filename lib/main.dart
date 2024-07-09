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
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
  routes: <String, WidgetBuilder>{
    '/': (context) => const WelcomePage(),
    '/second': (context) => const Homepage(),
     }
      );
  }
}

