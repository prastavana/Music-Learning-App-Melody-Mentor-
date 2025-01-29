import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_learning_app/core/common/snackbar/my_snackbar.dart'; // Import the snackbar helper
import 'package:music_learning_app/features/auth/presentation/view/register_view.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/dashboard_view.dart'; // Import DashboardView

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          Positioned(
            top: 495,
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
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35, vertical: 565),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 19),
                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Trigger login event
                          context.read<LoginBloc>().add(
                                LoginStudentEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                ),
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
                    // Register Navigation
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
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    context: context,
                                    destination: const RegisterView(),
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
                    // Listen to the LoginBloc state
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          // Show the snackbar first
                          showMySnackBar(
                            context: context,
                            message: "Login Successful",
                            color: Colors.green,
                          );

                          // Wait for the snackbar to finish before navigating
                          Future.delayed(const Duration(seconds: 2), () {
                            // Navigate to the DashboardView after successful login
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardView(),
                              ),
                            );
                          });
                        } else if (state.isLoading) {
                          // Optionally show a loading indicator
                          showMySnackBar(
                            context: context,
                            message: "Logging in...",
                            color: Colors.blueAccent,
                          );
                        }
                      },
                      child:
                          Container(), // Empty container as the listener does not require UI
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
