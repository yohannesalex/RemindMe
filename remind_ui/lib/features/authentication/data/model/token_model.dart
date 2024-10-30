import '../../domain/entity/tocken_entity.dart';

class TokenTakerModel extends TokenTakerEntity {
  const TokenTakerModel({required super.token});
  factory TokenTakerModel.fromJson(Map<String, dynamic> json) {
    return TokenTakerModel(token: json['access_token']);
  }
  static Map<String, dynamic> toJson(TokenTakerModel token) {
    return {
      'access_token': token,
    };
  }
}
