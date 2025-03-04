import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';

import '../view_model/dashboard_cubit.dart';
import '../view_model/dashboard_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait = screenHeight > screenWidth;

    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        return BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return Theme(
              data: themeData.copyWith(
                bottomNavigationBarTheme: themeData.bottomNavigationBarTheme,
              ),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: themeData.appBarTheme.backgroundColor,
                  title: Text(
                    'Melody Mentor',
                    style: GoogleFonts.kanit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: themeData.appBarTheme.foregroundColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.logout,
                          color: themeData.appBarTheme.foregroundColor),
                      onPressed: () {
                        context.read<DashboardCubit>().logout(context);
                      },
                    ),
                  ],
                ),
                body: _buildBody(context, state, isPortrait, screenHeight,
                    screenWidth, themeData),
                bottomNavigationBar: BottomNavigationBar(
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
                      icon: Icon(Icons.graphic_eq),
                      label: 'Tuner',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.play_arrow),
                      label: 'Session',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                  currentIndex: state.selectedIndex,
                  selectedItemColor:
                      themeData.bottomNavigationBarTheme.selectedItemColor,
                  unselectedItemColor:
                      themeData.bottomNavigationBarTheme.unselectedItemColor,
                  onTap: (index) {
                    context.read<DashboardCubit>().onTabTapped(index);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state, bool isPortrait,
      double screenHeight, double screenWidth, ThemeData themeData) {
    if (state.selectedIndex == 0) {
      return _buildHomeView(
          context, isPortrait, screenHeight, screenWidth, themeData);
    } else {
      return state.views[state.selectedIndex];
    }
  }

  Widget _buildHomeView(BuildContext context, bool isPortrait,
      double screenHeight, double screenWidth, ThemeData themeData) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait ? screenHeight * 0.01 : screenHeight * 0.10,
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
                          color: themeData.textTheme.bodyMedium?.color,
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
                      color: themeData.textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<DashboardCubit>().onTabTapped(5);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: isPortrait ? screenHeight * 0.04 : screenHeight * 0.04,
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
            ),
            GestureDetector(
              onTap: () {
                context.read<DashboardCubit>().onTabTapped(1);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: isPortrait ? screenHeight * 0.04 : screenHeight * 0.05,
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
                                  width: isPortrait ? 300 : screenWidth * 0.70,
                                  height: isPortrait ? 200 : screenWidth * 0.20,
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
                      child: GestureDetector(
                        onTap: () {
                          context.read<DashboardCubit>().onTabTapped(3);
                        },
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
                                    width:
                                        isPortrait ? 180 : screenWidth * 0.70,
                                    height:
                                        isPortrait ? 170 : screenWidth * 0.20,
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait ? screenHeight * 0.06 : screenHeight * 0.13,
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
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait ? screenHeight * 0.025 : screenHeight * 0.02,
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
                          'assets/images/song1.jpg',
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
  }
}
