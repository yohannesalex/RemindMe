import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../model/token_model.dart';

abstract class AuthLocalDataSource {
  Future<String> getToken();
  Future<void> cacheToken(TokenTakerModel tokenToCache);
  Future<void> deleteToken();
  Future<void> cacheEmail(String email);
  Future<String> getEmail();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_Token = 'CACHED_Token';
  final CACHED_Email = 'CACHED_Email';
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheToken(TokenTakerModel tokenToCache) {
    try {
      final cachedToken = tokenToCache.token;
      return sharedPreferences.setString(CACHED_Token, cachedToken);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheEmail(String email) {
    try {
      return sharedPreferences.setString(CACHED_Email, email);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String> getEmail() async {
    try {
      final cachedEmail = sharedPreferences.getString(CACHED_Email);
      if (cachedEmail != null) {
        return Future.value(cachedEmail);
      } else {
        throw CacheException();
      }
    } catch (e) {
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
      return sharedPreferences.remove(CACHED_Token);
    } catch (e) {
      throw CacheException();
    }
  }
}
