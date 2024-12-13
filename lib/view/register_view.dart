import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_learning_app/view/login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.kanit(
            fontWeight: FontWeight.w600,
            fontSize: 39,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.firaSans(
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

    // Get the screen height and keyboard height
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    bool isPortrait = screenHeight > screenWidth;

    // Define different top padding values for portrait and landscape
    double topPadding = isPortrait
        ? screenHeight * 0.505 // For portrait mode
        : screenHeight * 0.14; // For landscape mode, reduce space

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensure the screen resizes when keyboard appears
      body: Stack(
        children: [
          // Background Image - Positioned.fill ensures the image takes the whole screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/registerr-login.jpeg',
              fit: BoxFit.cover, // Ensures the image covers the whole screen
              alignment: Alignment.center, // Ensures the image is centered
            ),
          ),
          // UI Elements (text fields and buttons) over the background
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: topPadding, // Use calculated top padding
                left: 35,
                right: 35,
                bottom:
                    keyboardHeight + 20, // Adjust padding for keyboard height
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Create an Account Text
                  Padding(
                    padding: EdgeInsets.only(
                      top: isPortrait
                          ? screenHeight * 0.035
                          : screenHeight * 0.02,
                    ),
                    child: Center(
                      child: Text('Create an Account',
                          style: textTheme.displayLarge),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // First Name Field
                  _buildTextField('First Name'),
                  const SizedBox(height: 10),

                  // Last Name Field
                  _buildTextField('Last Name'),
                  const SizedBox(height: 10),

                  // Email Field
                  _buildTextField('Email'),
                  const SizedBox(height: 10),

                  // Password Field
                  _buildTextField('Password', obscureText: true),
                  const SizedBox(height: 10),

                  // Confirm Password Field
                  _buildTextField('Confirm Password', obscureText: true),
                  const SizedBox(height: 20),

                  // Register Button
                  ElevatedButton(
                    onPressed: () {
                      // Add registration logic here (e.g., validate fields, register the user)

                      // After successful registration, navigate to the LoginView screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      backgroundColor:
                          const Color(0xFF8FFCFF).withOpacity(0.56),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.firaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white, // Button text color
                      ),
                    ),
                  ),

                  // Already have an account? Login text
                  const SizedBox(height: 14), // Spacing
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.firaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white, // Text color
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Login screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.firaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white, // Text color
                              decoration: TextDecoration.underline, // Underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Container(
      height: 35,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.firaSans(
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }
}
