import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class AddMediaUsecase implements UseCase<void, AddParams> {
  final MediaRepository mediaRepository;
  AddMediaUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, void>> call(AddParams addparams) async {
    return await mediaRepository.addMedia(addparams.media);
  }
}

class AddParams extends Equatable {
  final MediaEntity media;

  const AddParams({required this.media});
  @override
  List<Object?> get props => [media];
}
