import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_learning_app/view/dashboard_view.dart';
import 'package:music_learning_app/view/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.kanit(
            fontWeight: FontWeight.w600,
            fontSize: 46,
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
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gettingstarted2.jpeg'),
                fit: BoxFit.cover, // This will zoom out the image a bit
                alignment: Alignment.center,
              ),
            ),
          ),
          // Welcome Text
          Positioned(
            top: isPortrait ? 495 : mediaQuery.size.height * 0.2,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Welcome Back !',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 38,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Login Form
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isPortrait
                    ? 35
                    : mediaQuery.size.width * 0.225, // 0.55 width in landscape
              ).copyWith(
                top: isPortrait ? 565 : mediaQuery.size.height * 0.4,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Email Field
                  Container(
                    width: isPortrait
                        ? double.infinity
                        : mediaQuery.size.width *
                            0.55, // 0.55 width in landscape
                    height: isPortrait ? 45 : mediaQuery.size.height * 0.11,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w800),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 19),

                  // Password Field
                  Container(
                    width: isPortrait
                        ? double.infinity
                        : mediaQuery.size.width *
                            0.55, // 0.55 width in landscape
                    height: isPortrait ? 42 : mediaQuery.size.height * 0.11,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w800),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Add login logic here, such as verifying credentials
                      // If login is successful:
                      bool isLoginSuccessful =
                          true; // Replace with actual logic

                      if (isLoginSuccessful) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardView(),
                          ),
                        );
                      } else {
                        // Show an error message if login fails
                        print('Login failed');
                      }
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
                      'Log In',
                      style: GoogleFonts.openSans(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Register Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.firaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
