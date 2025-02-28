import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_event.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_state.dart';

class SongView extends StatefulWidget {
  @override
  _SongViewState createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  String selectedCategory = 'Ukulele';

  @override
  void initState() {
    super.initState();
    _fetchSongs(); // Fetch songs initially
  }

  void _fetchSongs() {
    BlocProvider.of<SongBloc>(context)
        .add(FetchAllSongs(instrument: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chords View")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selector
            Row(
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
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: selectedCategory == category
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: selectedCategory == category
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Songs List
            Expanded(
              child: BlocBuilder<SongBloc, SongState>(
                builder: (context, state) {
                  if (state is SongLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SongError) {
                    return Center(child: Text("Error: ${state.message}"));
                  } else if (state is SongLoaded) {
                    List<SongEntity> songs = state.songs;
                    if (songs.isEmpty) {
                      return Center(
                          child: Text("No songs available in this category."));
                    }
                    return ListView.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        final song = songs[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              song.songName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              // Navigate to song details page
                              Navigator.pushNamed(context, '/song/${song.id}');
                            },
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                      child: Text("Select a category to load songs."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
