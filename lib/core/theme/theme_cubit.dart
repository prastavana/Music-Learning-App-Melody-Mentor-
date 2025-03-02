import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void toggleTheme() {
    print("Theme toggled. Current brightness: ${state.brightness}");
    emit(state.brightness == Brightness.dark
        ? AppTheme.lightTheme
        : AppTheme.darkTheme);
    print("Theme toggled. New brightness: ${state.brightness}");
  }
}
