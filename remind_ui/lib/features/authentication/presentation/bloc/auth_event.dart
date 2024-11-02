import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entity/login_entity.dart';
import '../../domain/entity/signup_entity.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogOutEvent extends AuthEvent {}

class GetMeEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final SignUpEntity user;

  const SignUpEvent(this.user);
  @override
  List<Object> get props => [user];
}

class LoginEvent extends AuthEvent {
  final LoginEntity user;

  const LoginEvent(this.user);
  @override
  List<Object> get props => [user];
}
