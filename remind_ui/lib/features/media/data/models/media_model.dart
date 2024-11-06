import 'package:remind_ui/features/media/domain/entities/media_entity.dart';

class MediaModel extends MediaEntity {
  const MediaModel(
      {required super.id,
      required super.userId,
      super.link,
      required super.category,
      super.imageUrl,
      super.remindBy,
      super.text,
      required super.createdAt});
  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      remindBy: json['remindBy'],
      imageUrl: json['imageUrl'],
      link: json['link'],
      text: json['text'],
      createdAt: json['createdAt'],
    );
  }
  static List<MediaModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => MediaModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'link': link,
      'imageUrl': imageUrl,
      'category': category,
      'remindBy': remindBy,
      'createdAt': createdAt,
      'text': text,
    };
  }

  MediaEntity toEntity() => MediaEntity(
      id: id,
      userId: userId,
      link: link,
      category: category,
      remindBy: remindBy,
      text: text,
      imageUrl: imageUrl,
      createdAt: createdAt);

  static List<MediaEntity> toEntityList(List<MediaModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static MediaModel toModel(MediaEntity media) {
    return MediaModel(
      id: media.id,
      userId: media.userId,
      link: media.link,
      text: media.text,
      imageUrl: media.imageUrl,
      category: media.category,
      remindBy: media.remindBy,
      createdAt: media.createdAt,
    );
  }

  static List<Map<String, dynamic>> toJsonList(List<MediaModel> medias) {
    return medias.map((media) => media.toJson()).toList();
  }
}
