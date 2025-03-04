// lib/features/sessions/presentation/view/session_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart'; // Import ThemeCubit
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/theme/colors.dart';
import '../../domain/entity/session_entity.dart';
import '../view_model/session_bloc.dart';
import '../view_model/session_event.dart';
import '../view_model/session_state.dart';

class SessionView extends StatefulWidget {
  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  String _selectedInstrument = 'ukulele';

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() {
    context.read<SessionBloc>().add(LoadSessionsEvent(_selectedInstrument));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      // Wrap with ThemeCubit BlocBuilder
      builder: (context, themeData) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sessions',
                style: TextStyle(
                    color: themeData
                        .appBarTheme.foregroundColor)), // Use themeData
            backgroundColor:
                themeData.appBarTheme.backgroundColor, // Use themeData
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeData.colorScheme.primary, // Use themeData
                  themeData.colorScheme.secondary, // Use themeData
                  themeData.colorScheme.tertiary, // Use themeData
                  themeData.colorScheme.surface, // Use themeData
                  themeData.colorScheme.background, // Use themeData
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: ["Ukulele", "Guitar", "Piano"].map((category) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedInstrument = category.toLowerCase();
                          });
                          _loadSessions();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  _selectedInstrument == category.toLowerCase()
                                      ? themeData
                                          .colorScheme.tertiary // Use themeData
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: _selectedInstrument ==
                                        category.toLowerCase()
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _selectedInstrument ==
                                        category.toLowerCase()
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<SessionBloc, SessionState>(
                    builder: (context, state) {
                      if (state is SessionLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: themeData
                                    .colorScheme.tertiary)); // Use themeData
                      } else if (state is SessionLoaded) {
                        return ListView.builder(
                          itemCount: state.sessions.length,
                          itemBuilder: (context, index) {
                            final session = state.sessions[index];
                            return ListTile(
                              title: Text(
                                '${session.day} - ${session.title}',
                                style: TextStyle(
                                    color: themeData.textTheme.bodyMedium
                                        ?.color), // Use themeData
                              ),
                              onTap: () {
                                _showSessionDetails(
                                    session, themeData); // Pass themeData
                              },
                            );
                          },
                        );
                      } else if (state is SessionError) {
                        return Center(
                            child: Text('Error: ${state.message}',
                                style: TextStyle(
                                    color: themeData.textTheme.bodyMedium
                                        ?.color))); // Use themeData
                      } else {
                        return Center(
                            child: Text('Select Instrument',
                                style: TextStyle(
                                    color: themeData.textTheme.bodyMedium
                                        ?.color))); // Use themeData
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSessionDetails(SessionEntity session, ThemeData themeData) {
    // Added ThemeData
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.modalGradientStart.withOpacity(0.8),
                AppColors.modalGradientEnd.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '${session.day} - ${session.title}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  session.description,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Duration: ${session.duration} minutes',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Instructions:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  session.instructions,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 20),
                if (session.file != null) _buildYouTubeVideo(session.file!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildYouTubeVideo(String youtubeUrl) {
    String? videoId = YoutubePlayer.convertUrlToId(youtubeUrl);
    if (videoId == null) {
      return Text('Invalid YouTube URL', style: TextStyle(color: Colors.red));
    }

    return StatefulBuilder(
      builder: (context, setState) {
        YoutubePlayerController _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

        return YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        );
      },
    );
  }
}
