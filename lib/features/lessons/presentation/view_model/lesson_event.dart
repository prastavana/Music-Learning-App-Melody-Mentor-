// features/lessons/presentation/view_model/lesson_event.dart

abstract class LessonEvent {}

class LoadLessonsEvent extends LessonEvent {
  final String? instrument;
  LoadLessonsEvent({this.instrument});
}
