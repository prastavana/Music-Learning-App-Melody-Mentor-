// features/lessons/domain/use_case/get_lesson_usecase.dart

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/lesson_entity.dart';
import '../repository/lesson_repository.dart';

class GetLessonsUseCase {
  final ILessonRepository repository;

  GetLessonsUseCase({required this.repository});

  Future<Either<Failure, List<LessonEntity>>> call(String? instrument) async {
    final result = await repository.getAllLessons();

    return result.fold(
      (failure) => Left(failure),
      (lessons) {
        if (instrument != null) {
          final filteredLessons = lessons
              .where((lesson) => lesson.instrument == instrument)
              .toList();
          print('Filtered Lessons: $filteredLessons'); // Added print
          return Right(filteredLessons);
        }
        print('All Lessons: $lessons'); // Added print
        return Right(lessons);
      },
    );
  }
}
