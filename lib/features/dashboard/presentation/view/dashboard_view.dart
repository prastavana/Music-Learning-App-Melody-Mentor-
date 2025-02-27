import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_state.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        bool isPortrait = screenHeight > screenWidth;

        return Scaffold(
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Main content
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Welcome message
                    Padding(
                      padding: EdgeInsets.only(
                        top: isPortrait
                            ? screenHeight * 0.07
                            : screenHeight * 0.10,
                        left: 34,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'HI Pasta!',
                                style: GoogleFonts.kanit(
                                  fontSize: isPortrait ? 30 : 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset('assets/icons/wave.jpg',
                                  width: 30, height: 30),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Welcome to Melody Mentor',
                            style: TextStyle(
                                fontSize: isPortrait ? 14 : 12,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // Explore card
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 5,
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explore your music learning journey!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 10),
                                    Text('GET STARTED',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              child: SizedBox(
                                width: isPortrait ? 180 : screenWidth * 0.3,
                                height: 130,
                                child: Image.asset(
                                  'assets/images/guitar1.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Two side-by-side cards
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<DashboardCubit>().onTabTapped(
                                    2); // Update tab to Chords page
                                // Use the new navigateToSongView method
                                context
                                    .read<DashboardCubit>()
                                    .navigateToSongView(context);
                              },
                              child: _buildFeatureCard(
                                'assets/images/guitar2.jpg',
                                'Play-along song',
                                'with chords',
                              ),
                            ),
                          ),
                          if (!isPortrait) const SizedBox(width: 20),
                          Expanded(
                            child: _buildFeatureCard(
                              'assets/images/pick.jpg',
                              'Tune your ',
                              'Instrument Easily',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Song list or loading
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocBuilder<SongBloc, SongState>(
                        builder: (context, songState) {
                          if (songState is SongLoading) {
                            return CircularProgressIndicator();
                          } else if (songState is SongError) {
                            return Text(
                              songState.message,
                              style: TextStyle(color: Colors.red),
                            );
                          } else if (songState is SongLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: songState.songs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(songState.songs[index]
                                      .songName), // Use songName here
                                );
                              },
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Lessons',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Chords',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tune),
                label: 'Tuner',
              ),
            ],
            currentIndex:
                state.selectedIndex, // Use selectedIndex from the state
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              context
                  .read<DashboardCubit>()
                  .onTabTapped(index); // Handle tab change
            },
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(String imagePath, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      color: Colors.white.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          height: 170,
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
