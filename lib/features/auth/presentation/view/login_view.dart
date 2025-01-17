import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:music_learning_app/core/common/snackbar/my_snackbar.dart';
import 'package:music_learning_app/features/auth/data/model/auth_hive_model.dart';
import 'package:music_learning_app/features/auth/presentation/view/register_view.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/login/login_bloc.dart';

import '../../../dashboard/presentation/view/dashboard_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardView(),
            ),
          );
        }

        if (!state.isSuccess && !state.isLoading) {
          showMySnackBar(
            context: context,
            message: "Invalid Credentials. Please try again.",
            color: Colors.red,
          );
        }

        if (state.isLoading) {
          showMySnackBar(
            context: context,
            message: "Logging in...",
            color: Colors.blue,
          );
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BackgroundImageScreen(),
      ),
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

    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gettingstarted2.jpeg'),
                fit: BoxFit.cover,
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
                horizontal: isPortrait ? 35 : mediaQuery.size.width * 0.225,
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
                        : mediaQuery.size.width * 0.55,
                    height: isPortrait ? 45 : mediaQuery.size.height * 0.11,
                    child: TextField(
                      controller: _emailController,
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
                        : mediaQuery.size.width * 0.55,
                    height: isPortrait ? 42 : mediaQuery.size.height * 0.11,
                    child: TextField(
                      controller: _passwordController,
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
                    onPressed: () async {
                      // Fetch user credentials from Hive
                      var box = await Hive.openBox<AuthHiveModel>('studentBox');
                      bool isValidUser = false;

                      for (var auth in box.values) {
                        if (auth.email == _emailController.text &&
                            auth.password == _passwordController.text) {
                          isValidUser = true;
                          break;
                        }
                      }

                      if (isValidUser) {
                        // Trigger login event if credentials are correct
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginStudentEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context,
                          ),
                        );
                      } else {
                        // Show a snackbar if the credentials are incorrect
                        showMySnackBar(
                          context: context,
                          message: "Invalid Credentials. Please try again.",
                          color: Colors.red,
                        );
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
