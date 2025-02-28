import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/error/failure.dart';

import '../entity/lesson_entity.dart';
import '../repository/lesson_repository.dart';

class GetLessonsUseCase {
  final ILessonRepository repository;

  GetLessonsUseCase({required this.repository});

  Future<Either<Failure, List<LessonEntity>>> call() async {
    // Changed execute to call
    return repository.getAllLessons();
  }
}
