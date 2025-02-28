// lib/features/session/data/datasource/remote_datasource.dart

import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../model/session_api_model.dart';
import 'session_data_source.dart'; // Import ISessionDataSource

class SessionRemoteDataSource implements ISessionDataSource {
  // Implement ISessionDataSource
  final Dio dio;

  SessionRemoteDataSource({required this.dio});

  @override
  Future<List<ApiSessionModel>> getAllSessions() async {
    try {
      final response =
          await dio.get('${ApiEndpoints.baseUrl}${ApiEndpoints.sessions}');

      if (response.statusCode == 200) {
        final List<dynamic> sessionsJson = response.data;
        return sessionsJson
            .map((json) => ApiSessionModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load sessions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load sessions: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load sessions: ${e.toString()}');
    }
  }
}
