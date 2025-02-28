import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.darkTheme); // Default theme is Dark

  void toggleTheme() {
    emit(state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme);
  }
}
