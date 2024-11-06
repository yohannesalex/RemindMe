import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../model/token_model.dart';

abstract class AuthLocalDataSource {
  Future<String> getToken();
  Future<void> cacheToken(TokenTakerModel tokenToCache);
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_Token = 'CACHED_Token';
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheToken(TokenTakerModel tokenToCache) {
    try {
      final cachedToken = tokenToCache.token;
      print("cachedToken: $cachedToken");
      return sharedPreferences.setString(CACHED_Token, cachedToken);
    } catch (e) {
      print("cacheToken error: $e");
      throw CacheException();
    }
  }

  @override
  Future<String> getToken() {
    try {
      final tokenString = sharedPreferences.getString(CACHED_Token);
      if (tokenString != null) {
        return Future.value(tokenString);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteToken() {
    try {
      print("token deleted");
      return sharedPreferences.remove(CACHED_Token);
    } catch (e) {
      throw CacheException();
    }
  }
}
