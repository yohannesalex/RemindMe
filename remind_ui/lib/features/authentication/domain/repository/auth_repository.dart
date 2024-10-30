import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/getme_entity.dart';
import '../entity/login_entity.dart';
import '../entity/signup_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(LoginEntity user);
  Future<Either<Failure, void>> signUp(SignUpEntity user);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, GetMeEntity>> getMe();
}
