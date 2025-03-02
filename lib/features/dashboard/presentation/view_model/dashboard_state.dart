import 'package:flutter/material.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/settings_view.dart';

import '../../../chords/presentation/view/song_view.dart';
import '../../../lessons/presentation/view/lesson_view.dart';
import '../../../tuner/presentation/view/tuner_view.dart'; // Import TunerView
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
          const DashboardView(),
          SongView(),
          LessonView(),
          TunerView(),
          SettingsView(), // Add TunerView to the list of views
          // SettingsView(),
        ],
      );

  DashboardState copyWith({int? selectedIndex}) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views,
    );
  }
}
