import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class EditMediaUsecase implements UseCase<void, EditParams> {
  final MediaRepository mediaRepository;
  EditMediaUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, void>> call(EditParams editParams) async {
    return await mediaRepository.editMedia(editParams.media);
  }
}

class EditParams extends Equatable {
  final MediaEntity media;

  const EditParams({required this.media});
  @override
  List<Object?> get props => [media];
}
