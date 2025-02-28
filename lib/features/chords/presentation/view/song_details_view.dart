import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../app/constants/api_endpoints.dart';

class SongDetailsView extends StatelessWidget {
  final Map<String, dynamic> song;

  SongDetailsView({required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(song['songName'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Warning: Lyrics may not be displayed correctly."),
            _buildSection(
              title: "Chord Diagrams",
              items: song['chordDiagrams'],
              itemBuilder: (item) => _buildImageWithLabel(item),
            ),
            _buildSection(
              title: "Lyrics",
              items: song['lyrics'],
              itemBuilder: (item) => _buildLyricText(item),
            ),
          ],
        ),
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
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...items.map((item) => itemBuilder(item)).toList(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildImageWithLabel(String imagePath) {
    final correctedImagePath = imagePath.replaceFirst("uploads/", "");
    final imageUrl = ApiEndpoints.imageUrl + correctedImagePath;
    print("Image URL: $imageUrl");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Diagram: $imagePath"),
          Image.network(
            imageUrl,
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
              return Column(
                children: [
                  Text('Failed to load image'),
                  Icon(Icons.error, color: Colors.red),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLyricText(dynamic lyric) {
    if (lyric is Map && lyric.containsKey('section')) {
      if (lyric.containsKey('parsedDocxFile') &&
          lyric['parsedDocxFile'] is List &&
          lyric['parsedDocxFile'].isNotEmpty) {
        final parsedLyric = lyric['parsedDocxFile'][0];
        if (parsedLyric is String) {
          if (parsedLyric == "[object Object]") {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Lyrics not available."),
            );
          }
          final parts = parsedLyric.split(",");
          bool allObjectObject = true;
          for (final part in parts) {
            if (part != "[object Object]") {
              allObjectObject = false;
              break;
            }
          }

          if (allObjectObject) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Lyrics not available."),
            );
          }
          try {
            // Attempt to parse the stringified array
            final parsedArray = json.decode(parsedLyric);
            if (parsedArray is List) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: parsedArray
                      .map<Widget>((item) => Text(item['lyrics'] ?? ''))
                      .toList(),
                ),
              );
            }
          } catch (e) {
            // If parsing fails, display the section
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text("Error parsing lyrics."),
                  Text("Section: ${lyric['section']}"),
                  Text("Please report this issue."),
                ],
              ),
            );
          }
        }
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(lyric['section']),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("Invalid Lyric Format"),
      );
    }
  }
}
