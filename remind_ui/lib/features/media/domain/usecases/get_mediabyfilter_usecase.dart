import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetMediabyfilterUsecase implements UseCase<void, GetByFilterParams> {
  final MediaRepository mediaRepository;
  GetMediabyfilterUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, List<MediaEntity>>> call(
      GetByFilterParams getByFilterparams) async {
    return await mediaRepository.getMediaByRemind(getByFilterparams.remindBy);
  }
}

class GetByFilterParams extends Equatable {
  final String remindBy;

  const GetByFilterParams({required this.remindBy});

  @override
  List<Object?> get props => [remindBy];
}
