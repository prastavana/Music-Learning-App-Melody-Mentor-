import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/app/constants/api_endpoints.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';

class SongDetailsView extends StatefulWidget {
  final Map<String, dynamic> song;

  const SongDetailsView({super.key, required this.song});

  @override
  _SongDetailsViewState createState() => _SongDetailsViewState();
}

class _SongDetailsViewState extends State<SongDetailsView> {
  late ScrollController _scrollController;
  bool _isAutoScrolling = false;
  double _scrollSpeed = 20.0; // Adjusted default speed (pixels per second)
  double _fontSize = 14.0; // Default font size
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _toggleAutoScroll() {
    setState(() {
      _isAutoScrolling = !_isAutoScrolling;
    });

    if (_isAutoScrolling) {
      _startAutoScroll();
    } else {
      _stopAutoScroll();
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel(); // Cancel any existing timer
    _scrollTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      // Slower interval for smoother control
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        if (currentScroll < maxScroll) {
          // Adjust scroll increment based on speed (pixels per second / updates per second)
          final increment =
              _scrollSpeed / 20; // 20 updates per second (1000ms / 50ms)
          _scrollController.jumpTo(currentScroll + increment);
        } else {
          _stopAutoScroll(); // Stop when reaching the end
        }
      }
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    setState(() {
      _isAutoScrolling = false;
    });
  }

  void _setScrollSpeed(double speed) {
    setState(() {
      _scrollSpeed = speed;
    });
    if (_isAutoScrolling) {
      _stopAutoScroll();
      _startAutoScroll(); // Restart with new speed
    }
  }

  void _adjustFontSize(double delta) {
    setState(() {
      _fontSize = (_fontSize + delta)
          .clamp(10.0, 30.0); // Limit font size between 10 and 30
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.song['songName'] ?? 'Unknown Song',
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
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warning: Lyrics may not be displayed correctly.",
                        style: TextStyle(
                          color: themeData.textTheme.bodyMedium?.color,
                          fontSize: _fontSize,
                        ),
                      ),
                      _buildSection(
                        title: "Chord Diagrams",
                        items: widget.song['chordDiagrams'] as List<dynamic>?,
                        itemBuilder: (item, themeData) =>
                            _buildImage(item as String, themeData),
                        themeData: themeData,
                      ),
                      _buildSection(
                        title: "Lyrics",
                        items: widget.song['lyrics'] as List<dynamic>?,
                        itemBuilder: (item, themeData) => _buildLyricText(
                            item as Map<String, dynamic>, themeData),
                        themeData: themeData,
                      ),
                    ],
                  ),
                ),
              ),
              // Control box at the bottom
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.purple[200], // Light purple background
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Font size decrease
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () => _adjustFontSize(-1),
                        tooltip: 'Decrease font size',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      // Font size increase
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () => _adjustFontSize(1),
                        tooltip: 'Increase font size',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      // Autoscroll toggle
                      IconButton(
                        icon: Icon(
                          _isAutoScrolling ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        color:
                            _isAutoScrolling ? Colors.blue[200] : Colors.black,
                        onPressed: _toggleAutoScroll,
                        tooltip: _isAutoScrolling
                            ? 'Stop Autoscroll'
                            : 'Start Autoscroll',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      // Speed adjustment
                      IconButton(
                        icon: Icon(Icons.speed, color: Colors.white),
                        onPressed: () => _showSpeedDialog(context),
                        tooltip: 'Adjust Scroll Speed',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
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

  void _showSpeedDialog(BuildContext context) {
    double tempSpeed = _scrollSpeed; // Temporary value for dialog
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Adjust Scroll Speed'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Speed: ${tempSpeed.toStringAsFixed(1)} px/s'),
                  Slider(
                    value: tempSpeed,
                    min: 10.0, // Slower minimum speed
                    max: 100.0, // Faster maximum speed
                    divisions: 18, // More granularity
                    label: tempSpeed.toStringAsFixed(1),
                    onChanged: (value) {
                      setDialogState(() {
                        tempSpeed = value; // Update temporary value in dialog
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _setScrollSpeed(tempSpeed); // Apply the selected speed
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Apply'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
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
            fontSize: _fontSize,
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
            fontSize: _fontSize + 2,
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
    final correctedImagePath = imagePath.startsWith("uploads/")
        ? imagePath.replaceFirst("uploads/", "")
        : imagePath;
    final imageUrl = ApiEndpoints.imageUrl + correctedImagePath;
    print('Loading image: $imageUrl');

    return SizedBox(
      width: 100,
      height: 100,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            print('Image loaded successfully: $imageUrl');
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
              'Image load error for $imageUrl: $exception, Stack: $stackTrace');
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
              fontSize: _fontSize + 2,
              color: themeData.textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 4),
          if (parsedDocxFile.isNotEmpty)
            ...parsedDocxFile.map((line) => Text(
                  line as String,
                  style: TextStyle(
                    fontSize: _fontSize,
                    color: themeData.textTheme.bodyMedium?.color,
                  ),
                ))
          else
            Text(
              "No lyrics available",
              style: TextStyle(
                fontSize: _fontSize,
                color: themeData.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
        ],
      ),
    );
  }
}
