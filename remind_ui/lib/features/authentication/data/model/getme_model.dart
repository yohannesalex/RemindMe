import '../../domain/entity/getme_entity.dart';

class GetMeResponseModel extends GetMeEntity {
  const GetMeResponseModel({
    required super.name,
  });
  GetMeEntity toEntity() {
    return GetMeEntity(name: name);
  }

  static GetMeResponseModel toModel(GetMeEntity user) {
    return GetMeResponseModel(
      name: user.name,
    );
  }
}
