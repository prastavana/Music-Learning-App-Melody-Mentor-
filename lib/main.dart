import 'package:flutter/material.dart';
import 'package:music_learning_app/app/app.dart';
import 'package:music_learning_app/app/di/di.dart';
import 'package:music_learning_app/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init(); // Initialize Hive with HiveService
  await initDependencies(); // Initialize dependencies from di.dart
  print('Main: Hive and dependencies initialized');
  runApp(const App());
}
