// lib/features/sessions/data/models/api_model.dart

class ApiSessionModel {
  final String id;
  final String instrument;
  final String day;
  final String title;
  final String description;
  final int duration;
  final String instructions;
  final String? file;

  ApiSessionModel({
    required this.id,
    required this.instrument,
    required this.day,
    required this.title,
    required this.description,
    required this.duration,
    required this.instructions,
    this.file,
  });

  factory ApiSessionModel.fromJson(Map<String, dynamic> json) {
    return ApiSessionModel(
      id: json['_id'],
      instrument: json['instrument'],
      day: json['day'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      instructions: json['instructions'],
      file: json['file'],
    );
  }
}
