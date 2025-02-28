import 'package:flutter/material.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/theme/colors.dart';

class SongDetailsView extends StatelessWidget {
  final Map<String, dynamic> song;

  SongDetailsView({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          song['songName'],
          style: TextStyle(
              color: Colors.white), // Set songName text color to white
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkGradientStart,
                  AppColors.darkGradientMid1,
                  AppColors.darkGradientMid2,
                  AppColors.darkGradientMid3,
                  AppColors.darkGradientEnd,
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
                    style: TextStyle(color: Colors.white),
                  ),
                  _buildSection(
                    title: "Chord Diagrams",
                    items: song['chordDiagrams'],
                    itemBuilder: (item) => _buildImage(item),
                  ),
                  _buildSection(
                    title: "Lyrics",
                    items: song['lyrics'],
                    itemBuilder: (item) => _buildLyricText(item),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<dynamic>? items,
    required Widget Function(dynamic item) itemBuilder,
  }) {
    if (items == null || items.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) => itemBuilder(item)).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
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

  Widget _buildLyricText(dynamic lyric) {
    if (lyric is Map && lyric.containsKey('section')) {
      if (lyric.containsKey('parsedDocxFile')) {
        final parsedLyric = lyric['parsedDocxFile'];
        if (parsedLyric is String && parsedLyric.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(parsedLyric, style: TextStyle(color: Colors.white)),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child:
                Text(lyric['section'], style: TextStyle(color: Colors.white)),
          );
        }
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(lyric['section'], style: TextStyle(color: Colors.white)),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
            Text("Invalid Lyric Format", style: TextStyle(color: Colors.white)),
      );
    }
  }
}
