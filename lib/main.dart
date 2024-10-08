import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_users_app/data/repository/user_profile_rep_imp.dart';
import 'package:github_users_app/domain/use_cases/user_details_useCase.dart';
import '/data/dataSources/remote/data_source.dart';
import '/domain/use_cases/get_users_useCase.dart';
import '/presentation/providers/user_provider.dart';
import '/data/repository/user_repository_impl.dart';
import '/presentation/providers/user_profile_provider.dart';
import '/presentation/providers/connectivity_provider.dart';
import '/presentation/screens/splash_screen.dart';
import '/data/datasources/remote/details_source.dart';
import '/presentation/providers/services/api_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = DataSource();
    final userRepository = UserRepositoryImpl(dataSource);
    final getUsersUseCase = GetUsersUseCase(userRepository);

    final detailsSource = DetailsSource();
    final userProfileRep = UserprofileRepImp(detailsSource);
    final userDetailsUseCase = UserDetailsUseCase(userProfileRep);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider(getUsersUseCase)),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(
            create: (_) => UserProfileProvider(userDetailsUseCase)),
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
