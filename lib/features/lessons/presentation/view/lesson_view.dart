import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../view_model/lesson_bloc.dart';
import '../view_model/lesson_event.dart';
import '../view_model/lesson_state.dart';

class LessonView extends StatefulWidget {
  @override
  _LessonViewState createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  String _selectedInstrument = 'ukulele';
  Set<int> completedLessons = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLessons();
    });
  }

  void _loadLessons() {
    context
        .read<LessonBloc>()
        .add(LoadLessonsEvent(instrument: _selectedInstrument));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lessons', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkGradientStart,
              AppColors.darkGradientMid1,
              AppColors.darkGradientMid2,
              AppColors.darkGradientMid3,
              AppColors.darkGradientEnd,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: ["Ukulele", "Guitar", "Piano"].map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedInstrument = category.toLowerCase();
                      });
                      _loadLessons();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedInstrument == category.toLowerCase()
                              ? AppColors.darkGradientMid2
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                _selectedInstrument == category.toLowerCase()
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: _selectedInstrument == category.toLowerCase()
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
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
                              Text(
                                '${lesson.day}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              if (isCompleted)
                                Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16.0,
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
                        completedLessons.add(index);
                      });
                      Navigator.pop(context);
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
