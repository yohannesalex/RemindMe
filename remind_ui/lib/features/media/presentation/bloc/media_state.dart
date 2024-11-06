import 'package:equatable/equatable.dart';
import 'package:remind_ui/features/media/domain/entities/media_entity.dart';

abstract class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object> get props => [];
}

class InitialState extends MediaState {}

class LoadingState extends MediaState {}

class SuccessState extends MediaState {}

class DeleteSuccessState extends MediaState {}

class UpdateSuccessState extends MediaState {}

class LoadedAllMediaState extends MediaState {
  final List<MediaEntity> mediaList;

  const LoadedAllMediaState({required this.mediaList});
}

class LoadedAllMediaByCategoryState extends MediaState {
  final List<MediaEntity> mediaList;

  const LoadedAllMediaByCategoryState({required this.mediaList});
}

class LoadedAllMediaByRemindState extends MediaState {
  final List<MediaEntity> mediaList;

  const LoadedAllMediaByRemindState({required this.mediaList});
}

class LoadedSingleMediaState extends MediaState {
  final MediaEntity media;

  const LoadedSingleMediaState({required this.media});
}

class ErrorState extends MediaState {
  final String message;

  const ErrorState({required this.message});
}
