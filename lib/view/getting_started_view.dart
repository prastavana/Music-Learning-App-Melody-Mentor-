import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_view.dart'; // Import your LoginView here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GettingStartedView());
}

class GettingStartedView extends StatelessWidget {
  const GettingStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 41,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 12.5,
            color: Colors.white,
          ),
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              OnboardingPage(
                title: 'Learn Together',
                subtitle: 'Explore new songs and chords',
                description:
                    'Play along to different songs to enhance your skills',
                imagePath: 'assets/images/instruments.jpg',
                subtitleFontSize: 20,
                descriptionFontSize: 14,
                titleFontSize: 30,
              ),
              OnboardingPage(
                title: 'Pitch Perfect',
                subtitle: 'Effortless Tuning',
                description:
                    'Achieve flawless sound with our easy-to-use tuning feature, designed to make your instruments performance-ready in no time.',
                imagePath: 'assets/images/ukulele3.jpg',
                subtitleFontSize: 22,
                descriptionFontSize: 12,
                titleFontSize: 32,
              ),
              OnboardingPage(
                title: 'Interested in',
                subtitle: 'learning music??',
                description:
                    'Try Melody Mentor and explore free lessons for different instruments at your ease.',
                imagePath: 'assets/images/gettingStarted.jpg',
                subtitleFontSize: 35,
                descriptionFontSize: 15,
                titleFontSize: 36,
                showGetStartedButton: true,
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: _currentPage == index
                          ? const Color(0xFFc900ff)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final double subtitleFontSize;
  final double descriptionFontSize;
  final double titleFontSize;
  final bool showGetStartedButton;
  final double opacity;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.subtitleFontSize,
    required this.descriptionFontSize,
    required this.titleFontSize,
    this.showGetStartedButton = false,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.14, sigmaY: 0.14),
            child: Container(
              color: Colors.white.withOpacity(opacity),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.35,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                  bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 7.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 85),
                    Text(
                      title,
                      style: textTheme.displayLarge!.copyWith(
                        fontSize: titleFontSize, // Dynamic title size
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: textTheme.displayLarge!.copyWith(
                        fontSize: subtitleFontSize,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: GoogleFonts.openSans(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    if (showGetStartedButton) ...[
                      const SizedBox(height: 27),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.translate(
                          offset: const Offset(-10, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF8FFCFF).withOpacity(0.56),
                              fixedSize: const Size(225, 70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                            ),
                            child: Text(
                              'GET STARTED',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
