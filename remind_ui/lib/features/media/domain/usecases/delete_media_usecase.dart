import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteMediaUsecase implements UseCase<void, DeleteParams> {
  final MediaRepository mediaRepository;
  DeleteMediaUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, void>> call(DeleteParams deleteparams) async {
    return await mediaRepository.deleteMedia(deleteparams.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  const DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
