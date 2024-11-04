import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:remind_ui/features/media/data/repository/media_repository_impl.dart';
import 'package:remind_ui/features/media/data/resource/media_local.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';
import 'package:remind_ui/features/media/domain/usecases/add_media_usecase.dart';
import 'package:remind_ui/features/media/domain/usecases/delete_media_usecase.dart';
import 'package:remind_ui/features/media/domain/usecases/get_allmeadia_usecase.dart';
import 'package:remind_ui/features/media/domain/usecases/get_mediabyId.dart';
import 'package:remind_ui/features/media/domain/usecases/get_mediabycatagory_usecase.dart';
import 'package:remind_ui/features/media/domain/usecases/get_mediabyfilter_usecase.dart';
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
import 'features/media/data/resource/media_remote.dart';
import 'features/media/domain/usecases/edit_media_usecase.dart';
import 'features/media/presentation/bloc/media_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthBloc(
        sl(),
        sl(),
        sl(),
        sl(),
      ));
  sl.registerFactory(() => MediaBloc(
        sl(),
        sl(),
        sl(),
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

  sl.registerLazySingleton(() => GetAllmeadiaUsecase(sl()));
  sl.registerLazySingleton(() => GetMediabyIdUsecase(sl()));
  sl.registerLazySingleton(() => GetMediabycatagoryUsecase(sl()));
  sl.registerLazySingleton(() => GetMediabyfilterUsecase(sl()));
  sl.registerLazySingleton(() => DeleteMediaUsecase(sl()));
  sl.registerLazySingleton(() => AddMediaUsecase(sl()));
  sl.registerLazySingleton(() => EditMediaUsecase(sl()));

  //repo
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authLocalDataSource: sl(),
        authRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<MediaRepository>(() => MediaRepositoryImpl(
        mediaLocalDataSource: sl(),
        mediaRemoteDataSource: sl(),
        networkInfo: sl(),
      ));

  //Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<MediaRemoteDataSource>(
      () => MediaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MediaLocalDataSource>(
      () => MediaLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
