import 'package:json_annotation/json_annotation.dart';

part 'lesson_api_model.g.dart';

@JsonSerializable()
class LessonApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String day;
  final String instrument;
  final List<QuizApiModel> quizzes;

  LessonApiModel({
    required this.id,
    required this.day,
    required this.instrument,
    required this.quizzes,
  });

  factory LessonApiModel.fromJson(Map<String, dynamic> json) =>
      _$LessonApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonApiModelToJson(this);
}

@JsonSerializable()
class QuizApiModel {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? chordDiagram;

  QuizApiModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.chordDiagram,
  });

  factory QuizApiModel.fromJson(Map<String, dynamic> json) =>
      _$QuizApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizApiModelToJson(this);
}
