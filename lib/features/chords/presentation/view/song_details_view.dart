import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';

import '../../../../app/constants/api_endpoints.dart';

class SongDetailsView extends StatelessWidget {
  final Map<String, dynamic> song;

  SongDetailsView({required this.song});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              song['songName'],
              style: TextStyle(color: themeData.appBarTheme.foregroundColor),
            ),
            backgroundColor: themeData.appBarTheme.backgroundColor,
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeData.colorScheme.primary,
                      themeData.colorScheme.secondary,
                      themeData.colorScheme.tertiary,
                      themeData.colorScheme.surface,
                      themeData.colorScheme.background,
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warning: Lyrics may not be displayed correctly.",
                        style: TextStyle(
                            color: themeData.textTheme.bodyMedium?.color),
                      ),
                      _buildSection(
                        title: "Chord Diagrams",
                        items: song['chordDiagrams'],
                        itemBuilder: (item, themeData) =>
                            _buildImage(item, themeData),
                        themeData: themeData,
                      ),
                      _buildSection(
                        title: "Lyrics",
                        items: song['lyrics'],
                        itemBuilder: (item, themeData) =>
                            _buildLyricText(item, themeData),
                        themeData: themeData,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required String title,
    required List<dynamic>? items,
    required Widget Function(dynamic item, ThemeData themeData) itemBuilder,
    required ThemeData themeData,
  }) {
    if (items == null || items.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeData.textTheme.bodyMedium?.color)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) => itemBuilder(item, themeData)).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImage(String imagePath, ThemeData themeData) {
    final correctedImagePath = imagePath.replaceFirst("uploads/", "");
    final imageUrl = ApiEndpoints.imageUrl + correctedImagePath;
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: themeData.colorScheme.tertiary,
            ),
          );
        },
        errorBuilder: (context, exception, stackTrace) {
          print('Image load error: $exception');
          return SizedBox(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLyricText(dynamic lyric, ThemeData themeData) {
    if (lyric is Map && lyric.containsKey('section')) {
      if (lyric.containsKey('parsedDocxFile')) {
        final parsedLyric = lyric['parsedDocxFile'];
        if (parsedLyric is String && parsedLyric.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(parsedLyric,
                style: TextStyle(color: themeData.textTheme.bodyMedium?.color)),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(lyric['section'],
                style: TextStyle(color: themeData.textTheme.bodyMedium?.color)),
          );
        }
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(lyric['section'],
            style: TextStyle(color: themeData.textTheme.bodyMedium?.color)),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Invalid Lyric Format",
            style: TextStyle(color: themeData.textTheme.bodyMedium?.color)),
      );
    }
  }
}
