import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkGradientMid2,
    scaffoldBackgroundColor: AppColors.darkGradientStart,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkAppBar,
      foregroundColor: AppColors.darkAppBarText,
      iconTheme: IconThemeData(color: AppColors.darkAppBarIcon),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavBarBackground,
      selectedItemColor: AppColors.darkNavBarSelected,
      unselectedItemColor: AppColors.darkNavBarUnselected,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    dividerColor: Colors.grey[800],
    // Add gradient colors to dark theme
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.darkGradientStart,
      secondary: AppColors.darkGradientMid1,
      tertiary: AppColors.darkGradientMid2,
      surface: AppColors.darkGradientMid3,
      background: AppColors.darkGradientEnd,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightGradientMid2,
    scaffoldBackgroundColor: AppColors.lightGradientStart,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightAppBar,
      foregroundColor: AppColors.lightAppBarText,
      iconTheme: IconThemeData(color: AppColors.lightAppBarIcon),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightNavBarBackground,
      selectedItemColor: AppColors.lightNavBarSelected,
      unselectedItemColor: AppColors.lightNavBarUnselected,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    dividerColor: Colors.grey[200],
    // Add gradient colors to light theme
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.lightGradientStart,
      secondary: AppColors.lightGradientMid1,
      tertiary: AppColors.lightGradientMid2,
      surface: AppColors.lightGradientEnd,
    ),
  );
}
