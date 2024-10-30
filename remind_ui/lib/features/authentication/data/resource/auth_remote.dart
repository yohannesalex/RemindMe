import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constant/api.dart';
import '../../../../core/error/exception.dart';
import '../model/getme_model.dart';
import '../model/login_model.dart';
import '../model/signup_model.dart';
import '../model/token_model.dart';

abstract class AuthRemoteDataSource {
  Future<GetMeResponseModel> getMe(String token);
  Future<TokenTakerModel> signUp(SignupResponseModel user);
  Future<TokenTakerModel> login(LoginResponseModel user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<GetMeResponseModel> getMe(String token) async {
    final response = await client.get(
      Uri.parse('${Uris.baseUrl}/users/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];
      return (GetMeResponseModel(name: data['name']));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TokenTakerModel> login(LoginResponseModel user) async {
    final jsonBody = {
      'id': "",
      'email': user.email,
      'password': user.password,
    };

    final response = await client.post(
      Uri.parse('${Uris.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      return (TokenTakerModel.fromJson(token));
    } else {
      throw InvalidUserCredentialsException();
    }
  }

  @override
  Future<TokenTakerModel> signUp(SignupResponseModel user) async {
    final jsonBody = {
      'id': "",
      'username': user.name,
      'email': user.email,
      'password': user.password,
    };

    final response = await client.post(
      Uri.parse('${Uris.baseUrl}/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];
      return token;
    } else if (response.statusCode == 409) {
      throw InvalidUserCredentialsException();
    } else {
      throw ServerException();
    }
  }
}
