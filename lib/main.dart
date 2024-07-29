import 'package:flutter/material.dart';
import 'package:githubusers/presentation/screens/homepage.dart';
import 'package:githubusers/presentation/screens/user_profile.dart';
import '/presentation/screens/welcome_page.dart';
import 'package:http/http.dart' as http;
import 'package:githubusers/domain/entities/user.dart';
import 'package:githubusers/presentation/widgets/infinite_scroll_pagination.dart';
import 'package:githubusers/presentation/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'data/datasources/remote/data_source.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/usecases/get_users_useCase.dart';
import 'presentation/providers/user_provider.dart';




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
