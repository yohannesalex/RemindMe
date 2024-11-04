import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/api.dart';
import '../../../../core/error/exception.dart';
import '../models/media_model.dart';

abstract class MediaRemoteDataSource {
  Future<List<MediaModel>> getAllMedia();
  Future<void> addMedia(MediaModel media);
  Future<void> deleteMedia(String mediaId);
  Future<void> editMedia(MediaModel media);
  Future<List<MediaModel>> getMediaByCategory(String category);
  Future<List<MediaModel>> getMediaByRemind(String remindby);
  Future<MediaModel> getMediabyId(String mediaId);
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final http.Client client;
  MediaRemoteDataSourceImpl({required this.client});

  @override
  Future<void> addMedia(MediaModel media) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/media/addContents');
    final request = http.MultipartRequest(
      'POST',
      uri,
    );
    request.fields.addAll({
      'category': media.category,
      'link': media.link ?? '',
      'text': media.text ?? '',
      'remindBy': media.remindBy ?? '',
    });
    if (media.imageUrl != '' && File(media.imageUrl!).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        media.imageUrl!,
        contentType: MediaType('image', 'jpg'),
      ));
    }

    request.headers['Authorization'] = 'Bearer $token';
    final response = await request.send();

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteMedia(String mediaId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final jsonBody = {'id': mediaId};
    final response = await client.delete(
      Uri.parse('${Uris.baseUrl}/media/delteContent'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(jsonBody),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> editMedia(MediaModel media) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final mediaId = media.id;
    final jsonBody = {
      'category': media.category,
      'remidBy': media.remindBy,
      'link': media.link,
      'text': media.text,
    };

    final response = await client.put(
      Uri.parse('${Uris.baseUrl}/media/updateContent$mediaId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(jsonBody),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<List<MediaModel>> getAllMedia() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/media/GetContents');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MediaModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MediaModel> getMediabyId(String mediaId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/media/$mediaId');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MediaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MediaModel>> getMediaByCategory(String category) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri =
        Uri.parse('${Uris.baseUrl}/media/GetContentByCategory/$category');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MediaModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MediaModel>> getMediaByRemind(String remindBy) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('CACHED_Token');
    final uri = Uri.parse('${Uris.baseUrl}/media/GetContentByRemind/$remindBy');
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MediaModel.fromJsonList(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
