// lib/features/sessions/domain/repository/session_repository.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/session_entity.dart';

abstract interface class ISessionRepository {
  Future<Either<Failure, List<SessionEntity>>> getAllSessions(
      {String? instrument});
}
