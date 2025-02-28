// lib/features/sessions/data/repository/remote_repository.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/session_entity.dart';
import '../../domain/repository/session_repository.dart';
import '../data_source/session_remote_data_source.dart';
import '../model/session_api_model.dart';

class SessionRemoteRepository implements ISessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SessionEntity>>> getAllSessions(
      {String? instrument}) async {
    try {
      final sessions = await remoteDataSource.getAllSessions();
      List<ApiSessionModel> filteredSessions = sessions;
      if (instrument != null) {
        filteredSessions = sessions
            .where((session) =>
                session.instrument.toLowerCase() == instrument!.toLowerCase())
            .toList();
      }
      return Right(filteredSessions.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}

extension ApiSessionModelToEntity on ApiSessionModel {
  SessionEntity toEntity() {
    return SessionEntity(
      id: this.id,
      instrument: instrument,
      day: day,
      title: title,
      description: description,
      duration: duration,
      instructions: instructions,
      file: file,
    );
  }
}
