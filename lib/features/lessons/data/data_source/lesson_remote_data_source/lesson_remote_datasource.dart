import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../app/constants/api_endpoints.dart';
import '../../model/lesson_api_model.dart';

class RemoteDataSource {
  Future<List<LessonApiModel>> getLessons() async {
    final response =
        await http.get(Uri.parse('${ApiEndpoints.baseUrl}/getquiz'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<LessonApiModel> lessons =
          body.map((dynamic item) => LessonApiModel.fromJson(item)).toList();
      return lessons;
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}
