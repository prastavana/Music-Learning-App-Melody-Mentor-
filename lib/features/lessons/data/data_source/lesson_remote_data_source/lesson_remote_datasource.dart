import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../model/lesson_api_model.dart';

class LessonRemoteDataSource {
  final Dio _dio;

  LessonRemoteDataSource(this._dio);

  Future<List<LessonApiModel>> getAllLessons() async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}/getquiz');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data; // Use response.data for dio
        List<LessonApiModel> lessons =
            body.map((dynamic item) => LessonApiModel.fromJson(item)).toList();
        return lessons;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        print(
            'Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
      } else {
        print('Dio error! Request: ${e.requestOptions}, Message: ${e.message}');
      }
      rethrow; // Re-throw the exception to be handled elsewhere
    } catch (e) {
      // Handle other exceptions
      print('General error: $e');
      rethrow; // Re-throw the exception
    }
  }
}
