import '../../domain/entity/lesson_entity.dart';

abstract interface class ILessonDataSource {
  Future<List<LessonEntity>> getAllLessons();
}
