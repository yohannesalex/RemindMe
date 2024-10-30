import 'package:equatable/equatable.dart';

class TokenTakerEntity extends Equatable {
  final String token;

  const TokenTakerEntity({
    required this.token,
  });
  @override
  List<Object?> get props => [token];
}
