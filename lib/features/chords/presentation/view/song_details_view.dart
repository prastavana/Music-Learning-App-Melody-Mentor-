import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/app/constants/api_endpoints.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';

class SongDetailsView extends StatelessWidget {
  final Map<String, dynamic> song;

  const SongDetailsView({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              song['songName'] ?? 'Unknown Song',
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
                      _buildSection(
                        title: "Chord Diagrams",
                        items: song['chordDiagrams'] as List<dynamic>?,
                        itemBuilder: (item, themeData) =>
                            _buildImage(item as String, themeData),
                        themeData: themeData,
                      ),
                      _buildSection(
                        title: "Lyrics",
                        items: song['lyrics'] as List<dynamic>?,
                        itemBuilder: (item, themeData) => _buildLyricText(
                            item as Map<String, dynamic>, themeData),
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
    if (items == null || items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          "$title: Not available",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeData.textTheme.bodyMedium?.color,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeData.textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) => itemBuilder(item, themeData)).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImage(String imagePath, ThemeData themeData) {
    final correctedImagePath = imagePath.replaceFirst("uploads/", "");
    final imageUrl = ApiEndpoints.imageUrl + correctedImagePath;
    print('Loading image: $imageUrl'); // Log the URL being loaded

    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            print('Image loaded successfully: $imageUrl'); // Log success
            return child;
          }
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
          print(
              'Image load error for $imageUrl: $exception, Stack: $stackTrace'); // Enhanced error logging
          return SizedBox(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                const Text(
                  'Image unavailable',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLyricText(Map<String, dynamic> lyric, ThemeData themeData) {
    final section = lyric['section'] as String? ?? 'Unnamed Section';
    final parsedDocxFile = lyric['parsedDocxFile'] as List<dynamic>? ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: themeData.textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          if (parsedDocxFile.isNotEmpty)
            ...parsedDocxFile.map((line) => Text(
                  line as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: themeData.textTheme.bodyMedium?.color,
                  ),
                ))
          else
            Text(
              "No lyrics available",
              style: TextStyle(
                fontSize: 14,
                color: themeData.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
        ],
      ),
    );
  }
}
