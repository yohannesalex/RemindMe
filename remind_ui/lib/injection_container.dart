import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/authentication/data/repositoryImplemantation/auth_repositiry_impl.dart';
import 'features/authentication/data/resource/auth_local.dart';
import 'features/authentication/data/resource/auth_remote.dart';
import 'features/authentication/domain/repository/auth_repository.dart';
import 'features/authentication/domain/usecase/getme_usecase.dart';
import 'features/authentication/domain/usecase/login_usecase.dart';
import 'features/authentication/domain/usecase/logout_usecsse.dart';
import 'features/authentication/domain/usecase/signup_usecase.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ));

  // Usecases
  sl.registerLazySingleton(() => GetMeUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  //repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authLocalDataSource: sl(),
        authRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
