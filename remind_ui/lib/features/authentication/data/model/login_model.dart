import '../../domain/entity/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  const LoginResponseModel({
    required super.email,
    required super.password,
  });

  static LoginResponseModel toModel(LoginEntity user) {
    return LoginResponseModel(
      email: user.email,
      password: user.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
