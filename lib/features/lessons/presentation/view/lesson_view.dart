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
  String _selectedInstrument = 'ukulele';
  Set<int> completedLessons = {}; // Store completed lesson indices.

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
                  value: 'ukulele',
                  label: Text('Ukulele'),
                ),
                ButtonSegment<String>(
                  value: 'guitar',
                  label: Text('Guitar'),
                ),
                ButtonSegment<String>(
                  value: 'piano',
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
                  return ListView.builder(
                    itemCount: state.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = state.lessons[index];
                      bool isCompleted = completedLessons.contains(index);

                      return ListTile(
                        title: Row(
                          children: [
                            Text('${lesson.day}'),
                            Spacer(), // This will push the checkmark to the right
                            if (isCompleted)
                              Container(
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: Colors.green, // Green background
                                  shape: BoxShape.circle, // Circular shape
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white, // White checkmark
                                  size: 16.0, // Smaller size for the checkmark
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          _showLessonDetails(lesson, index);
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

  void _showLessonDetails(lesson, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Map<int, String> selectedOptions = {};

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.63,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Day: ${lesson.day}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lesson.quizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = lesson.quizzes[index];

                        return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quiz.question,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              if (quiz.chordDiagram != null)
                                Image.network(
                                  'http://10.0.2.2:3000/uploads/${quiz.chordDiagram}',
                                  height: 100,
                                  width: 100,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Text('Failed to load image'),
                                ),
                              SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: quiz.options.map<Widget>((option) {
                                  bool isSelected =
                                      selectedOptions[index] == option;

                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? Colors.blueGrey
                                          : Colors.grey[300],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selectedOptions[index] = option;
                                      });
                                    },
                                    child: Text(option.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        completedLessons
                            .add(index); // Mark this lesson as completed.
                      });
                      Navigator.pop(
                          context); // Close the modal after submission.
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
