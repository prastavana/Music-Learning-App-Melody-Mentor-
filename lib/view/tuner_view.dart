import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TunerView extends StatelessWidget {
  const TunerView({super.key});

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
                // Back button and Lessons text at the top
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0), // Space from the top
                  child: Row(
                    children: [
                      // Back Button
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Navigate back to DashboardView
                          Navigator.of(context).pop();
                        },
                      ),
                      // Lessons text
                      Text(
                        'Tuner',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Space before other content
                const SizedBox(height: 20),
                // Placeholder for content
                const Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
