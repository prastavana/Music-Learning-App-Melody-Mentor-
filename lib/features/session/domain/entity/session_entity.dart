// lib/features/sessions/domain/entity/session_entity.dart

class SessionEntity {
  final String id;
  final String instrument;
  final String day;
  final String title;
  final String description;
  final int duration;
  final String instructions;
  final String? file;

  SessionEntity({
    required this.id,
    required this.instrument,
    required this.day,
    required this.title,
    required this.description,
    required this.duration,
    required this.instructions,
    this.file,
  });
}
