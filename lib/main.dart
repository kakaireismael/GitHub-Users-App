import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/presentation/providers/user_provider.dart';
import '/presentation/providers/user_profile_provider.dart';
import '/presentation/providers/connectivity_provider.dart';
import '/presentation/screens/splash_screen.dart';
import 'package:github_users_app/core/di/service_locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<UserProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<ConnectivityProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<UserProfileProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub Users App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFFFFF)),
          useMaterial3: true,
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}
