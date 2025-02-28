import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';
import 'package:music_learning_app/features/chords/presentation/view/song_details_view.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_event.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_state.dart';

import '../../../../core/theme/colors.dart';

class SongView extends StatefulWidget {
  @override
  _SongViewState createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  String selectedCategory = 'Ukulele';

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  void _fetchSongs() {
    BlocProvider.of<SongBloc>(context)
        .add(FetchAllSongs(instrument: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Song View", style: TextStyle(color: Colors.white)),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                          selectedCategory = category;
                        });
                        _fetchSongs();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedCategory == category
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
                              fontWeight: selectedCategory == category
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selectedCategory == category
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
                child: BlocBuilder<SongBloc, SongState>(
                  builder: (context, state) {
                    if (state is SongLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.darkGradientMid2,
                        ),
                      );
                    } else if (state is SongError) {
                      return Center(
                        child: Text("Error: ${state.message}",
                            style: TextStyle(color: Colors.red)),
                      );
                    } else if (state is SongLoaded) {
                      List<SongEntity> songs = state.songs;
                      if (songs.isEmpty) {
                        return Center(
                          child: Text("No songs available in this category.",
                              style: TextStyle(color: Colors.grey)),
                        );
                      }
                      return ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(song.songName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SongDetailsView(song: song.toJson()),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text("Select a category to load songs.",
                          style: TextStyle(color: Colors.grey)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
