import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/media_entity.dart';

abstract class MediaRepository {
  Future<Either<Failure, List<MediaEntity>>> getAllMedia();
  Future<Either<Failure, void>> addMedia(MediaEntity meadia);
  Future<Either<Failure, void>> deleteMedia(String id);
  Future<Either<Failure, void>> editMedia(MediaEntity media);
  Future<Either<Failure, List<MediaEntity>>> getMediaByCategory(
      String category);
  Future<Either<Failure, List<MediaEntity>>> getMediaByRemind(String remindby);
  Future<Either<Failure, MediaEntity>> getMediaById(String id);
}
