import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/getme_entity.dart';
import '../repository/auth_repository.dart';

class GetMeUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  GetMeUseCase(this.authRepository);

  @override
  Future<Either<Failure, GetMeEntity>> call(NoParams noParams) async {
    return await authRepository.getMe();
  }
}
