import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view/song_view.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_bloc.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/dashboard_view.dart';

import '../../../../app/di/di.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({
    required this.selectedIndex,
    required this.views,
  });

  /// Initial state of the dashboard
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
        const DashboardView(),
        BlocProvider(
          create: (context) => getIt<SongBloc>(),
          child: SongView(),
        ),
      ],
    );
  }

  /// Returns a new instance of DashboardState with updated values
  DashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
