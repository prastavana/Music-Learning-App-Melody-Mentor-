// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonApiModel _$LessonApiModelFromJson(Map<String, dynamic> json) =>
    LessonApiModel(
      id: json['_id'] as String,
      day: json['day'] as String,
      instrument: json['instrument'] as String,
      quizzes: (json['quizzes'] as List<dynamic>)
          .map((e) => QuizApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonApiModelToJson(LessonApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'day': instance.day,
      'instrument': instance.instrument,
      'quizzes': instance.quizzes,
    };

QuizApiModel _$QuizApiModelFromJson(Map<String, dynamic> json) => QuizApiModel(
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
      chordDiagram: json['chordDiagram'] as String?,
    );

Map<String, dynamic> _$QuizApiModelToJson(QuizApiModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'chordDiagram': instance.chordDiagram,
    };
