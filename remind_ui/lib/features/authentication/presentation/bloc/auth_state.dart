import 'package:equatable/equatable.dart';

import '../../domain/entity/getme_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class LogOutSuccessState extends AuthState {}

class GetMeSuccessState extends AuthState {
  final GetMeEntity user;

  const GetMeSuccessState({required this.user});
}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState({required this.message});
}

class SignUpErrorState extends AuthState {
  final String message;

  const SignUpErrorState({required this.message});
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});
}
