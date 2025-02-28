import '../../domain/entity/lesson_entity.dart';

abstract class LessonState {}

class LessonInitialState extends LessonState {}

class LessonLoadingState extends LessonState {}

class LessonLoadedState extends LessonState {
  final List<LessonEntity> lessons;

  LessonLoadedState({required this.lessons});
}

class LessonErrorState extends LessonState {
  final String message;

  LessonErrorState({required this.message});
}
