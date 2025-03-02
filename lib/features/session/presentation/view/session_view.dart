// lib/features/sessions/presentation/view/session_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
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
                          color: _selectedInstrument == category.toLowerCase()
                              ? AppColors.darkGradientMid2
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                _selectedInstrument == category.toLowerCase()
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: _selectedInstrument == category.toLowerCase()
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
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SessionLoaded) {
                    return ListView.builder(
                      itemCount: state.sessions.length,
                      itemBuilder: (context, index) {
                        final session = state.sessions[index];
                        return ListTile(
                          title: Text(
                            '${session.day} - ${session.title}',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            _showSessionDetails(session);
                          },
                        );
                      },
                    );
                  } else if (state is SessionError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Center(child: Text('Select Instrument'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSessionDetails(SessionEntity session) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkGradientMid1, // Set background color
      shape: RoundedRectangleBorder(
        // Set rounded corners
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${session.day} - ${session.title}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 15),
                Text('Description: ${session.description}',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text('Duration: ${session.duration} minutes',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Text('Instructions: ${session.instructions}',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 15),
                if (session.file != null)
                  _buildYouTubeVideo(session.file!), // Display YouTube video
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
  }
}
