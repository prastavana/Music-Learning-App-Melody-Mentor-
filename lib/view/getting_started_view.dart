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
          displayLarge: GoogleFonts.kanit(
            fontWeight: FontWeight.w600,
            fontSize: 41,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 12.5,
            color: Colors.white,
          ),
        ),
      ),
      home: const BackgroundImageScreen(),
    );
  }
}

class BackgroundImageScreen extends StatelessWidget {
  const BackgroundImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gettingStarted.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Whitish blur effect overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.14, sigmaY: 0.14),
              child: Container(
                color: Colors.white.withOpacity(0.20),
              ),
            ),
          ),
          // Scrollable content (no landscape check anymore)
          Positioned(
            left: 21, // Adjust for portrait (no landscape condition)
            top: screenHeight *
                0.35, // Adjust for portrait (no landscape condition)
            child: SingleChildScrollView(
              child: Container(
                width: 368, // Fixed width for portrait
                height: 495, // Fixed height for portrait
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, // Fixed padding for portrait
                    vertical: 7.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 85),
                      Text('Interested in', style: textTheme.displayLarge),
                      const SizedBox(height: 6),
                      Text('learning', style: textTheme.displayLarge),
                      const SizedBox(height: 6),
                      Text('music??', style: textTheme.displayLarge),
                      const SizedBox(height: 24),
                      Text(
                        'Try Melody Mentor and explore free lessons ',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'for different instruments at your ease',
                        style: textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 27),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.translate(
                          offset: const Offset(
                              -10, 0), // Move 10 pixels to the left
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the LoginView screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8FFCFF)
                                  .withOpacity(0.56), // Reduced transparency
                              fixedSize:
                                  const Size(225, 70), // Fixed button size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    35), // Rounded corners
                              ),
                              alignment:
                                  Alignment.centerLeft, // Align text to left
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                            ),
                            child: Text(
                              'GET STARTED',
                              style: GoogleFonts.firaSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white, // White text color
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50), // Spacing below the button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
