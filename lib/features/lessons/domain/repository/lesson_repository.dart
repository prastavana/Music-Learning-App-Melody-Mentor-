import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/lesson_entity.dart';

abstract interface class ILessonRepository {
  Future<Either<Failure, List<LessonEntity>>> getAllLessons();
}
