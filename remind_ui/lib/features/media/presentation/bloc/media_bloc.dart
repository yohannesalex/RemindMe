import 'package:bloc/bloc.dart';
import 'package:remind_ui/features/media/domain/usecases/get_allmeadia_usecase.dart';
import 'package:remind_ui/features/media/presentation/bloc/media_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/add_media_usecase.dart';
import '../../domain/usecases/delete_media_usecase.dart';
import '../../domain/usecases/edit_media_usecase.dart';
import '../../domain/usecases/get_mediabyId.dart';
import '../../domain/usecases/get_mediabycatagory_usecase.dart';
import '../../domain/usecases/get_mediabyfilter_usecase.dart';
import 'media_event.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final GetAllmeadiaUsecase _getAllmediaUsecase;
  final EditMediaUsecase _editMediaUsecase;
  final DeleteMediaUsecase _deleteMediaUsecase;
  final AddMediaUsecase _addMediaUsecase;
  final GetMediabyIdUsecase _getMediabyIdUsecase;
  final GetMediabyfilterUsecase _getMediabyfilterUsecase;
  final GetMediabycatagoryUsecase _getMediabycatagoryUsecase;

  MediaBloc(
    this._getAllmediaUsecase,
    this._editMediaUsecase,
    this._deleteMediaUsecase,
    this._addMediaUsecase,
    this._getMediabyIdUsecase,
    this._getMediabyfilterUsecase,
    this._getMediabycatagoryUsecase,
  ) : super(InitialState()) {
    on<GetSingleMediaEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await _getMediabyIdUsecase(GetByIdparams(id: event.mediaId));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedSingleMediaState(media: data));
      });
    }, transformer: debounce(const Duration(milliseconds: 300)));
    on<LoadAllMediaEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _getAllmediaUsecase();

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedAllMediaState(mediaList: data));
      });
    });
    on<GetMediaByCategoryEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _getMediabycatagoryUsecase(
          GetByCatagoryparams(category: event.category));

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedAllMediaByCategoryState(mediaList: data));
      });
    });
    on<GetMediaByRemindEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _getMediabyfilterUsecase(
          GetByFilterParams(remindBy: event.remindBy));

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoadedAllMediaByRemindState(mediaList: data));
      });
    });
    on<UpdateMediaEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _editMediaUsecase(EditParams(media: event.media));

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(UpdateSuccessState());
      });
    });
    on<CreateMediaEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _addMediaUsecase(AddParams(media: event.media));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(SuccessState());
      });
    });
    on<DeleteMediaEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _deleteMediaUsecase(DeleteParams(id: event.mediaId));
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(DeleteSuccessState());
      });
    });
  }
}

EventTransformer<GetSingleMediaEvent> debounce<T>(Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
