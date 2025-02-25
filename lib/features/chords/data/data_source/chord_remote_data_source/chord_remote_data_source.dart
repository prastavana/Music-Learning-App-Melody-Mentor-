import 'package:dio/dio.dart';

import '../model/api_model.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource({required this.dio});

  Future<List<SongModel>> fetchSongs({String? instrument}) async {
    final response = await dio.get(
      'https://your-api-url.com/getsongs',
      queryParameters: instrument != null ? {'instrument': instrument} : null,
    );

    if (response.statusCode == 200) {
      return (response.data['songs'] as List)
          .map((json) => SongModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  Future<SongModel> fetchSongById(String id) async {
    final response = await dio.get('https://your-api-url.com/getsong/$id');

    if (response.statusCode == 200) {
      return SongModel.fromJson(response.data);
    } else {
      throw Exception('Song not found');
    }
  }
}
