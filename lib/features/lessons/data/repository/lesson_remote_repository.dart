import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/lesson_entity.dart';
import '../../domain/repository/lesson_repository.dart';
import '../data_source/lesson_data_source.dart';

class LessonRemoteRepository implements ILessonRepository {
  final ILessonDataSource remoteDataSource;

  LessonRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LessonEntity>>> getAllLessons() async {
    try {
      final lessons = await remoteDataSource.getAllLessons();
      return Right(lessons); // Return the lessons if the fetch is successful
    } catch (e) {
      return Left(ApiFailure(
          message: e.toString())); // Return an error in case of failure
    }
  }
}
