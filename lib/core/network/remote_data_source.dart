// core/network/remote_data_source.dart
import 'package:dio/dio.dart';

import 'api_service.dart';
import 'data_source.dart';

class RemoteDataSource<T> implements DataSource<T> {
  final ApiService apiService;

  RemoteDataSource(this.apiService);

  @override
  Future<T> getRemoteData() async {
    try {
      final response =
          await apiService.dio.get('/your-api-endpoint'); // Replace
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load remote data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load remote data: $e');
    }
  }

  @override
  Future<T> getLocalData() async {
    throw UnimplementedError();
  }
}
