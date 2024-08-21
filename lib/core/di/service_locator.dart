import 'package:get_it/get_it.dart';
import 'package:github_users_app/data/repository/user_profile_rep_imp.dart';
import 'package:github_users_app/domain/use_cases/user_details_use_case.dart';
import 'package:github_users_app/data/dataSources/remote/data_source.dart';
import 'package:github_users_app/domain/use_cases/get_users_use_case.dart';
import 'package:github_users_app/presentation/providers/user_provider.dart';
import 'package:github_users_app/data/repository/user_repository_impl.dart';
import 'package:github_users_app/presentation/providers/user_profile_provider.dart';
import 'package:github_users_app/presentation/providers/connectivity_provider.dart';
import 'package:github_users_app/data/datasources/remote/details_source.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register Data Sources
  getIt.registerLazySingleton<DataSource>(() => DataSource());
  getIt.registerLazySingleton<DetailsSource>(() => DetailsSource());

  // Register Repositories
  getIt.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl(getIt<DataSource>()));
  getIt.registerLazySingleton<UserprofileRepImp>(() => UserprofileRepImp(getIt<DetailsSource>()));

  // Register Use Cases
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt<UserRepositoryImpl>()));
  getIt.registerLazySingleton<UserDetailsUseCase>(() => UserDetailsUseCase(getIt<UserprofileRepImp>()));

  // Register Providers
  getIt.registerFactory<UserProvider>(() => UserProvider(getIt<GetUsersUseCase>()));
  getIt.registerFactory<ConnectivityProvider>(() => ConnectivityProvider());
  getIt.registerFactory<UserProfileProvider>(() => UserProfileProvider(getIt<UserDetailsUseCase>()));
}
