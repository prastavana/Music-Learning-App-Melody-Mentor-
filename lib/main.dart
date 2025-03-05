import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_learning_app/features/chords/data/model/song_hive_model.dart';

import 'app/app.dart';
import 'app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive for Flutter
  Hive.registerAdapter(
      SongHiveModelAdapter()); // Register SongHiveModel adapter
  Hive.registerAdapter(
      LyricSectionHiveModelAdapter()); // Register LyricSectionHiveModel adapter
  await Hive.openBox<SongHiveModel>('songsBox'); // Open a Hive box for songs
  await initDependencies(); // Initialize dependencies from di.dart
  runApp(const App());
}
