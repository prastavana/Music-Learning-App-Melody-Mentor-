import 'package:flutter/material.dart';

import '../../../chords/presentation/view/song_view.dart';
import '../../../lessons/presentation/view/lesson_view.dart';
import '../../../session/presentation/view/session_view.dart';
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
        selectedIndex: 0, // Default to DashboardView
        views: [
          DashboardView(), // Index 0
          SongView(), // Index 1
          LessonView(), // Index 2
          SessionView(), // Index 3
          SettingView(), // Index 4
        ],
      );

  DashboardState copyWith({int? selectedIndex}) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views,
    );
  }
}
