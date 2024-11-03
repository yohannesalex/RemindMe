import 'package:equatable/equatable.dart';

class MediaEntity extends Equatable {
  final String id;
  final String userId;
  final String? text;
  final String? link;
  final String? imageUrl;
  final String category;
  final String? remindBy;
  final String createdAt;
  const MediaEntity(
      {required this.id,
      required this.userId,
      this.text,
      this.link,
      this.imageUrl,
      required this.category,
      this.remindBy,
      required this.createdAt});
  @override
  List<Object?> get props =>
      [id, userId, text, link, imageUrl, category, remindBy, createdAt];
}
