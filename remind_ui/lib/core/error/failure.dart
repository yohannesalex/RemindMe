import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class SocketFailure extends Failure {}

class ConnectionFailure extends Failure {}

class InvalidUserCredientialFailure extends Failure {}

class UserAlreadyExistFailure extends Failure {}
