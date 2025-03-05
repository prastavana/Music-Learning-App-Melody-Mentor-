import 'package:flutter/material.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/settings_view.dart';
import 'package:music_learning_app/features/session/presentation/view/session_view.dart';
import 'package:music_learning_app/features/tuner/presentation/view/tuner_view.dart';

import '../../../chords/presentation/view/song_view.dart';
import '../../../lessons/presentation/view/lesson_view.dart';
import '../view/dashboard_view.dart';

@immutable
class DashboardState {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({
    required this.selectedIndex,
    required this.views,
  });

  factory DashboardState.initial() => DashboardState(
        selectedIndex: 0,
        views: [
          DashboardView(),
          SongView(),
          LessonView(),
          SessionView(),
          TunerPage(),
          SettingsView(), // Add TunerView to the list of views
        ],
      );

  DashboardState copyWith({int? selectedIndex}) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views,
    );
  }
}
