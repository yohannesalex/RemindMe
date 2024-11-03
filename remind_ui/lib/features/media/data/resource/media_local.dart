import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/media_model.dart';

abstract class MediaLocalDataSource {
  Future<List<MediaModel>> getAllProducts();
  Future<void> cacheAllProducts(List<MediaModel> mediaToCache);
}

class MediaLocalDataSourceImpl implements MediaLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_MEDIAS = 'CACHED_MEDIAS';
  MediaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheAllProducts(List<MediaModel> mediaToCache) {
    try {
      final jsonMedia = json.encode(MediaModel.toJsonList(mediaToCache));

      return sharedPreferences.setString(CACHED_MEDIAS, jsonMedia);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<MediaModel>> getAllProducts() {
    try {
      final mediasString = sharedPreferences.getString(CACHED_MEDIAS);
      if (mediasString != null) {
        final decodedJson = json.decode(mediasString);

        return Future.value(MediaModel.fromJsonList(decodedJson));
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
