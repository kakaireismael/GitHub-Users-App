import 'package:flutter/material.dart';
import 'package:githubusers/features/presentation/screens/user_profile.dart';
import 'features/presentation/screens/welcome_page.dart';
import 'features/presentation/screens/homepage.dart';
import 'package:http/http.dart' as http;
import '../widgets/user_widget.dart';
import 'package:githubusers/features/domain/entities/user.dart';
import 'package:githubusers/features/presentation/widgets/infinite_scroll.dart';
import 'package:githubusers/features/presentation/widgets/splash_screen.dart';


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
    '/': (context) => const SplashScreen(),
    '/second': (context) => const WelcomePage(),
    '/third': (context) => const HomePage(),
     }
      );
  }
}
