import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg', // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),
          // UI Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lessons text at the top
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0), // Space from the top
                  child: Text(
                    'Lessons',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Space before other content
                const SizedBox(height: 20),
                // You can replace the Placeholder with actual content here
                const Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
