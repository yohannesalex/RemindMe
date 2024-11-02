import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/getme_entity.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/entity/signup_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../resource/auth_local.dart';
import '../resource/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.networkInfo,
      required this.authLocalDataSource});

  @override
  Future<Either<Failure, void>> login(LoginEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await authRemoteDataSource.login(LoginResponseModel.toModel(user));

        await authLocalDataSource.cacheToken(result);
        return const Right(null);
      } catch (e) {
        if (e is InvalidUserCredentialsException) {
          return Left(InvalidUserCredientialFailure());
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      authLocalDataSource.deleteToken();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUp(SignUpEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemoteDataSource
            .signUp(SignupResponseModel.toModel(user));
        await authLocalDataSource.cacheToken(result);

        return const Right(null);
      } catch (e) {
        if (e is UserAlreadyExistException) {
          return Left(UserAlreadyExistFailure());
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetMeEntity>> getMe() async {
    if (await networkInfo.isConnected) {
      final cachedToken = await authLocalDataSource.getToken();
      try {
        final result = await authRemoteDataSource.getMe(cachedToken);
        return Right(result.toEntity());
      } catch (e) {
        if (e is CacheException) {
          return Left(CacheFailure());
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
