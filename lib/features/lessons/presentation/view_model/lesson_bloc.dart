// features/lessons/presentation/view_model/lesson_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/get_lesson_usecase.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessonsUseCase getLessonsUseCase;

  LessonBloc({required this.getLessonsUseCase}) : super(LessonInitialState()) {
    on<LoadLessonsEvent>((event, emit) async {
      emit(LessonLoadingState());
      final result = await getLessonsUseCase.call(event.instrument);

      result.fold(
        (failure) {
          emit(LessonErrorState(message: failure.message));
        },
        (lessons) {
          emit(LessonLoadedState(lessons: lessons));
        },
      );
    });
  }
}
