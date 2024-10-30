import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await authRepository.logout();
  }
}
