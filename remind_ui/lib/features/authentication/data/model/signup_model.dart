import '../../domain/entity/signup_entity.dart';

class SignupResponseModel extends SignUpEntity {
  const SignupResponseModel({
    required super.name,
    required super.email,
    required super.password,
  });
  static SignupResponseModel toModel(SignUpEntity user) {
    return SignupResponseModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': name,
      'email': email,
      'password': password,
    };
  }
}
