import 'package:dartz/dartz.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllmeadiaUsecase {
  final MediaRepository mediaRepository;
  GetAllmeadiaUsecase(this.mediaRepository);
  Future<Either<Failure, List<MediaEntity>>> call() {
    return mediaRepository.getAllMedia();
  }
}
