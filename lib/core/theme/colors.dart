import 'package:flutter/material.dart';

class AppColors {
  // 🌙 Dark Mode
  static const Color darkAppBar = Colors.black;
  static const Color darkAppBarText = Colors.white;
  static const Color darkAppBarIcon = Colors.white;

  static const Color darkGradientStart = Colors.black;
  static const Color darkGradientMid1 = Color(0xFF1F0B6F);
  static const Color darkGradientMid2 = Color(0xFF3C19AA);
  static const Color darkGradientMid3 = Color(0xFF6929CF);
  static const Color darkGradientEnd = Color(0xFFB964E9);

  static const Color darkNavBarBackground = Colors.black;
  static const Color darkNavBarSelected = Color(0xFFB964E9);
  static const Color darkNavBarUnselected = Colors.white;

  // ☀️ Light Mode
  static const Color lightAppBar = Color(0xFFADD8E6); // Light Blue
  static const Color lightAppBarText = Colors.black;
  static const Color lightAppBarIcon = Colors.black;

  static const Color lightGradientStart = Color(0xFFADD8E6); // Light Blue
  static const Color lightGradientMid1 = Color(0xFFD0B3FF); // Soft Lavender
  static const Color lightGradientMid2 = Color(0xFFE6CCFF); // Light Lavender
  static const Color lightGradientEnd =
      Color(0xFFF3E6FF); // Very Light Lavender

  static const Color lightNavBarBackground = Colors.white;
  static const Color lightNavBarSelected = Color(0xFFB964E9);
  static const Color lightNavBarUnselected = Colors.black;

  // Modal Colors
  static const Color modalGradientStart =
      Color(0xFF7A68A6); // Even Darker Lavender
  static const Color modalGradientEnd =
      Color(0xFF4A89B8); // Even Darker Sky Blue

// Custom Success and Warning Colors
  static const Color successColor = Color(0xFF4CAF50); // Green
  static const Color warningColor = Color(0xFFFFC107); // Yellow
}
