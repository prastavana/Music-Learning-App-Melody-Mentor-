import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lesson_view.dart'; // Import the LessonView page

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Lessons Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Chords Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Tuner Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // Navigate to LessonView when 'Lessons' is clicked
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LessonView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait = screenHeight > screenWidth;

    return Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              height: double.infinity,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset('assets/images/background.jpg'),
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
                  // Two side-by-side cards (play-along and take the pick)
                  Padding(
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
                                      width:
                                          isPortrait ? 300 : screenWidth * 0.70,
                                      height:
                                          isPortrait ? 200 : screenWidth * 0.20,
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
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'with chords',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
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
                                                color: Colors.white),
                                          ),
                                          Text(
                                            'Instrument Easily ',
                                            style: TextStyle(
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
                          ),
                        ),
                      ],
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
                      alignment:
                          Alignment.centerLeft, // Align the text to the left
                      child: Text(
                        'Play your first beginner song',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                                    'IM Yours',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  Text('Beginner Lesson Sheet',
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
                              width: isPortrait ? 180 : screenWidth * 0.45,
                              height: isPortrait ? 105 : screenWidth * 0.13,
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
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black, // Keeping the original color
            elevation: 5,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books, color: Colors.white),
                label: 'Lessons',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note, color: Colors.white),
                label: 'Chords',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tune, color: Colors.white),
                label: 'Tuner',
              ),
            ],
          ),
        ));
  }
}
