import 'package:bloc/bloc.dart';
import 'package:remind_ui/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';

import '../../domain/usecase/getme_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/logout_usecsse.dart';
import '../../domain/usecase/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetMeUseCase _getMeUsecase;
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(
    this._getMeUsecase,
    this._loginUseCase,
    this._signUpUseCase,
    this._logoutUseCase,
  ) : super(AuthInitialState()) {
    on<GetMeEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        final result = await _getMeUsecase(NoParams());
        print('getme bloc----------$result');
        result.fold((failure) {
          emit(const AuthErrorState(message: 'unable to load'));
        }, (data) {
          emit(GetMeSuccessState(user: data));
        });
      },
    );
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _signUpUseCase(SignUpParams(user: event.user));
      result.fold((failure) {
        if (failure is UserAlreadyExistFailure) {
          emit(const SignUpErrorState(message: 'User already exist'));
        }
      }, (data) {
        emit(SignUpSuccessState());
      });
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _loginUseCase(LoginParams(user: event.user));

      result.fold((failure) {
        if (failure is InvalidUserCredientialFailure) {
          emit(const LoginErrorState(message: 'User does not exist'));
        }
      }, (data) {
        emit(LoginSuccessState());
      });
    });
    on<LogOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _logoutUseCase(NoParams());

      result.fold((failure) {
        emit(const AuthErrorState(message: 'unable to load'));
      }, (data) {
        emit(LogOutSuccessState());
      });
    });
  }
}
