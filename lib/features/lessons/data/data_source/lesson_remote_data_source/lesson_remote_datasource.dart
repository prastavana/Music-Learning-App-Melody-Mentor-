// lesson_remote_data_source.dart

import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/lesson_entity.dart';
import '../../model/lesson_api_model.dart'; // Ensure correct path
import '../lesson_data_source.dart'; // Ensure correct path

class LessonRemoteDataSource implements ILessonDataSource {
  final Dio _dio;

  LessonRemoteDataSource(this._dio);

  @override
  Future<List<LessonEntity>> getAllLessons() async {
    try {
      final response = await _dio.get(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getAllLessons}'); // Uses endpoint

      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> body = response.data;
          List<LessonApiModel> lessonApiModels = body
              .map((dynamic item) => LessonApiModel.fromJson(item))
              .toList();

          // Convert LessonApiModel to LessonEntity
          List<LessonEntity> lessonEntities = lessonApiModels
              .map((lessonApiModel) => LessonEntity(
                    id: lessonApiModel.id,
                    day: lessonApiModel.day,
                    instrument: lessonApiModel.instrument,
                    quizzes: lessonApiModel.quizzes
                        .map((quizApiModel) => QuizEntity(
                              question: quizApiModel.question,
                              options: quizApiModel.options,
                              correctAnswer: quizApiModel.correctAnswer,
                              chordDiagram: quizApiModel.chordDiagram,
                            ))
                        .toList(),
                  ))
              .toList();

          return lessonEntities;
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: 'Response data is not a List',
          );
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error:
              'Failed to load lessons from ${ApiEndpoints.baseUrl}${ApiEndpoints.getAllLessons}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(
            'Dio error! Status: ${e.response?.statusCode}, Data: ${e.response?.data}, Endpoint: ${ApiEndpoints.baseUrl}${ApiEndpoints.getAllLessons}');
        if (e.type == DioExceptionType.connectionTimeout) {
          print('Connection timeout error');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('Receive timeout error');
        }
      } else {
        print(
            'Dio error! Request: ${e.requestOptions}, Message: ${e.message}, Endpoint: ${ApiEndpoints.baseUrl}${ApiEndpoints.getAllLessons}');
      }
      rethrow;
    } catch (e) {
      print(
          'General error: $e, Endpoint: ${ApiEndpoints.baseUrl}${ApiEndpoints.getAllLessons}');
      rethrow;
    }
  }
}
