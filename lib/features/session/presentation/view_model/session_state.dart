import '../../domain/entity/session_entity.dart';

abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionLoaded extends SessionState {
  final List<SessionEntity> sessions;
  SessionLoaded(this.sessions);
}

class SessionError extends SessionState {
  final String message;
  SessionError(this.message);
}
