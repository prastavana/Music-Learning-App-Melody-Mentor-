// lib/features/sessions/data/datasource/remote_datasource.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/session_api_model.dart';

abstract class SessionRemoteDataSource {
  Future<List<ApiSessionModel>> getAllSessions();
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final http.Client client;

  SessionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ApiSessionModel>> getAllSessions() async {
    final response = await client.get(
      Uri.parse('http://YOUR_IP:3000/sessions'), // Replace with your API URL
    );

    if (response.statusCode == 200) {
      final List<dynamic> sessionsJson = json.decode(response.body);
      return sessionsJson
          .map((json) => ApiSessionModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load sessions');
    }
  }
}
