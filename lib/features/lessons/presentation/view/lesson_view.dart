// features/lessons/presentation/view/lesson_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/lesson_bloc.dart';
import '../view_model/lesson_event.dart';
import '../view_model/lesson_state.dart';

class LessonView extends StatefulWidget {
  @override
  _LessonViewState createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  String _selectedInstrument = 'Ukulele'; // Default instrument

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  void _loadLessons() {
    context
        .read<LessonBloc>()
        .add(LoadLessonsEvent(instrument: _selectedInstrument));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lessons')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'Ukulele',
                  label: Text('Ukulele'),
                ),
                ButtonSegment<String>(
                  value: 'Guitar',
                  label: Text('Guitar'),
                ),
                ButtonSegment<String>(
                  value: 'Piano',
                  label: Text('Piano'),
                ),
              ],
              selected: <String>{_selectedInstrument},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedInstrument = newSelection.first;
                  _loadLessons();
                });
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                if (state is LessonLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LessonLoadedState) {
                  final filteredLessons = state.lessons
                      .where(
                          (lesson) => lesson.instrument == _selectedInstrument)
                      .toList();

                  return ListView.builder(
                    itemCount: filteredLessons.length,
                    itemBuilder: (context, index) {
                      final lesson = filteredLessons[index];
                      return ListTile(
                        title: Text('Day: ${lesson.day}'), // Display only day
                        onTap: () {
                          _showLessonDetails(lesson); // Show details on tap
                        },
                      );
                    },
                  );
                } else if (state is LessonErrorState) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('Select Instrument'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _loadLessons();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _showLessonDetails(lesson) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day: ${lesson.day}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: lesson.quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = lesson.quizzes[index];
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
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
