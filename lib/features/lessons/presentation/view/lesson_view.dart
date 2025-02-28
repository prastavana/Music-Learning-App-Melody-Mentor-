import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/lesson_bloc.dart';
import '../view_model/lesson_event.dart';
import '../view_model/lesson_state.dart';

class LessonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lessons')),
      body: BlocBuilder<LessonBloc, LessonState>(
        builder: (context, state) {
          if (state is LessonLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LessonLoadedState) {
            return ListView.builder(
              itemCount: state.lessons.length,
              itemBuilder: (context, index) {
                final lesson = state.lessons[index];
                return ExpansionTile(
                  title: Text(
                      'Day: ${lesson.day}, Instrument: ${lesson.instrument}'),
                  children: lesson.quizzes.map((quiz) {
                    return ListTile(
                      title: Text(quiz.question),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Options: ${quiz.options.join(', ')}'),
                          Text('Correct Answer: ${quiz.correctAnswer}'),
                          if (quiz.chordDiagram != null)
                            Text('Chord Diagram: ${quiz.chordDiagram}'),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          } else if (state is LessonErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Load Lessons'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LessonBloc>().add(LoadLessonsEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
