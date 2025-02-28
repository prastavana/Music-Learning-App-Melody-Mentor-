import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../chords/presentation/view/song_view.dart';
import '../../../chords/presentation/view_model/song_bloc.dart';
import '../view_model/dashboard_cubit.dart';
import '../view_model/dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait = screenHeight > screenWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set AppBar to black
        title: Text(
          'Melody Mentor',
          style: GoogleFonts.kanit(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white, // White text for the title
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // White icon
            onPressed: () {
              context.read<DashboardCubit>().logout(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black, // Black at the top
                  Color(0xFF1F0B6F), // Intermediate dark purple
                  Color(0xFF3C19AA), // Purple
                  Color(0xFF6929CF), // Light purple
                  Color(0xFFB964E9), // Lighter purple
                ],
                stops: [0.35, 0.65, 0.75, 0.85, 1.0],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Welcome message
                  Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait
                          ? screenHeight * 0.01
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
                            Image.asset(
                              'assets/icons/wave.jpg',
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Welcome to Melody Mentor',
                          style: TextStyle(
                            fontSize: isPortrait ? 14 : 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Explore card
                  Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait
                          ? screenHeight * 0.04
                          : screenHeight * 0.04,
                      left: 20,
                      right: 20,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
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
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'GET STARTED',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
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
                  // Two side-by-side cards (play-along and take the pick)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: context.read<SongBloc>(),
                            child: SongView(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isPortrait
                            ? screenHeight * 0.04
                            : screenHeight * 0.05,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              color: Colors.white.withOpacity(0.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: SizedBox(
                                  height: 170,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/guitar2.jpg',
                                        fit: BoxFit.cover,
                                        width: isPortrait
                                            ? 300
                                            : screenWidth * 0.70,
                                        height: isPortrait
                                            ? 200
                                            : screenWidth * 0.20,
                                      ),
                                      const Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Play-along song',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'with chords',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!isPortrait) const SizedBox(width: 20),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              color: Colors.white.withOpacity(0.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: 170,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/pick.jpg',
                                        width: isPortrait
                                            ? 180
                                            : screenWidth * 0.70,
                                        height: isPortrait
                                            ? 170
                                            : screenWidth * 0.20,
                                        fit: BoxFit.cover,
                                      ),
                                      const Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Tune your ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Instrument Easily ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text for beginner song
                  Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait
                          ? screenHeight * 0.06
                          : screenHeight * 0.13,
                      left: 35,
                      right: 20,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Play your first beginner song',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Card with IM Yours song
                  Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait
                          ? screenHeight * 0.025
                          : screenHeight * 0.02,
                      left: 20,
                      right: 20,
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
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
                                    'IM Yours by Jason Mraz',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Start learning now!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
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
                                'assets/images/imv.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Ensure black background
        unselectedItemColor: Colors.white, // White unselected icons
        selectedItemColor: const Color(0xFFB964E9), // Purple selected icon
        currentIndex: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Song',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Lesson',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Session',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
