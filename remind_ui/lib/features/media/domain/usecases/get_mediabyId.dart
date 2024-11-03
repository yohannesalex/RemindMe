import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetMediabyIdUsecase implements UseCase<void, GetByIdparams> {
  final MediaRepository mediaRepository;
  GetMediabyIdUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, MediaEntity>> call(GetByIdparams getByIdparams) async {
    return await mediaRepository.getMediaById(getByIdparams.id);
  }
}

class GetByIdparams extends Equatable {
  final String id;

  const GetByIdparams({required this.id});

  @override
  List<Object?> get props => [id];
}
