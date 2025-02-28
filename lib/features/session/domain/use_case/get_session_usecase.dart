// lib/features/sessions/domain/usecase/get_sessions.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/session_entity.dart';
import '../repository/session_repository.dart';

class GetSessionsUseCase {
  final ISessionRepository repository;

  GetSessionsUseCase({required this.repository});

  Future<Either<Failure, List<SessionEntity>>> call(
      {String? instrument}) async {
    return repository.getAllSessions(instrument: instrument);
  }
}
