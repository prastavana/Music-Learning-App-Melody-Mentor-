import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/song_entity.dart';
import '../song_data_source.dart';

class SongRemoteDataSource implements ISongDataSource {
  final Dio _dio;

  SongRemoteDataSource(this._dio);

  @override
  Future<List<SongEntity>> getAllSongs({String? instrument}) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (instrument != null) {
        queryParams['instrument'] = instrument;
      }

      Response response = await _dio.get(
        ApiEndpoints.getAllSongs,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        List<dynamic> data =
            response.data['songs']; // Assuming response contains 'songs'
        return data.map((song) => SongEntity.fromJson(song)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SongEntity> getSongById(String id) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.getSongById}/$id',
      );

      if (response.statusCode == 200) {
        var data = response.data['song']; // Assuming response contains 'song'
        return SongEntity.fromJson(data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
