// lib/features/session/data/data_source/session_data_source.dart

import '../model/session_api_model.dart';

abstract class ISessionDataSource {
  Future<List<ApiSessionModel>> getAllSessions();
}
