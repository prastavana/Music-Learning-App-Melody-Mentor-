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
  );
}
