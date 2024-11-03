import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';
import 'package:remind_ui/features/media/domain/repository/media_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetMediabycatagoryUsecase implements UseCase<void, GetByCatagoryparams> {
  final MediaRepository mediaRepository;
  GetMediabycatagoryUsecase(this.mediaRepository);

  @override
  Future<Either<Failure, List<MediaEntity>>> call(
      GetByCatagoryparams getByCategoryparams) async {
    return await mediaRepository
        .getMediaByCategory(getByCategoryparams.category);
  }
}

class GetByCatagoryparams extends Equatable {
  final String category;

  const GetByCatagoryparams({required this.category});

  @override
  List<Object?> get props => [category];
}
