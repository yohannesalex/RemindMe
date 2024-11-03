import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/media_entity.dart';
import '../../domain/repository/media_repository.dart';
import '../models/media_model.dart';
import '../resource/media_local.dart';
import '../resource/media_remote.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRemoteDataSource mediaRemoteDataSource;
  final MediaLocalDataSource mediaLocalDataSource;
  final NetworkInfo networkInfo;

  MediaRepositoryImpl(
      {required this.mediaRemoteDataSource,
      required this.mediaLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, void>> addMedia(MediaEntity media) async {
    if (await networkInfo.isConnected) {
      try {
        await mediaRemoteDataSource.addMedia(MediaModel.toModel(media));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedia(String mediaId) async {
    if (await networkInfo.isConnected) {
      try {
        await mediaRemoteDataSource.deleteMedia(mediaId);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editMedia(MediaEntity media) async {
    if (await networkInfo.isConnected) {
      try {
        await mediaRemoteDataSource.editMedia(MediaModel.toModel(media));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<MediaEntity>>> getAllMedia() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await mediaRemoteDataSource.getAllMedia();
        await mediaLocalDataSource.cacheAllProducts(result);

        return Right(MediaModel.toEntityList(result));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await mediaLocalDataSource.getAllProducts();
        return Right(MediaModel.toEntityList(result));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, MediaEntity>> getMediaById(String mediaId) async {
    if (await networkInfo.isConnected) {
      networkInfo.isConnected;
      try {
        return (Right(await mediaRemoteDataSource.getMediabyId(mediaId)));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<MediaEntity>>> getMediaByCategory(
      String category) async {
    if (await networkInfo.isConnected) {
      networkInfo.isConnected;
      try {
        return (Right(
            await mediaRemoteDataSource.getMediaByCategory(category)));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<MediaEntity>>> getMediaByRemind(
      String remindBy) async {
    if (await networkInfo.isConnected) {
      networkInfo.isConnected;
      try {
        return (Right(await mediaRemoteDataSource.getMediaByRemind(remindBy)));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
