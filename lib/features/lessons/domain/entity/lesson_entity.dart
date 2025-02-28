class LessonEntity {
  final String id;
  final String day;
  final String instrument;
  final List<QuizEntity> quizzes;

  LessonEntity({
    required this.id,
    required this.day,
    required this.instrument,
    required this.quizzes,
  });
}

class QuizEntity {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? chordDiagram;

  QuizEntity({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.chordDiagram,
  });
}
