import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/media_entity.dart';

@immutable
abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class LoadAllMediaEvent extends MediaEvent {}

class GetSingleMediaEvent extends MediaEvent {
  final String mediaId;

  const GetSingleMediaEvent(this.mediaId);
  @override
  List<Object> get props => [mediaId];
}

class GetMediaByCategoryEvent extends MediaEvent {
  final String category;

  const GetMediaByCategoryEvent(this.category);
  @override
  List<Object> get props => [category];
}

class GetMediaByRemindEvent extends MediaEvent {
  final String remindBy;

  const GetMediaByRemindEvent(this.remindBy);
  @override
  List<Object> get props => [remindBy];
}

class UpdateMediaEvent extends MediaEvent {
  final MediaEntity media;

  const UpdateMediaEvent(this.media);
  @override
  List<Object> get props => [media];
}

class CreateMediaEvent extends MediaEvent {
  final MediaEntity media;

  const CreateMediaEvent(this.media);
  @override
  List<Object> get props => [media];
}

class DeleteMediaEvent extends MediaEvent {
  final String mediaId;

  const DeleteMediaEvent(this.mediaId);
  @override
  List<Object> get props => [mediaId];
}
