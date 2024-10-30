import 'package:equatable/equatable.dart';

class GetMeEntity extends Equatable {
  final String name;

  const GetMeEntity({
    required this.name,
  });
  @override
  List<Object?> get props => [name];
}
