import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
        const Center(
          child: Text('Dashboard'),
        ),
      ],
    );
  }

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
