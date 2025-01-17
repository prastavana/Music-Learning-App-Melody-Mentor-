import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/network/hive_service.dart';
import '../../data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import '../../data/repository/auth_local_repository/auth_local_repository.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_case/register_user_usecase.dart';
import '../view_model/signup/register_bloc.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide HiveService
        Provider<HiveService>(
          create: (context) =>
              HiveService(), // Make sure to initialize HiveService correctly
        ),
        // Provide AuthLocalDataSource with HiveService
        Provider<AuthLocalDataSource>(
          create: (context) => AuthLocalDataSource(context.read<HiveService>()),
        ),
        // Provide IAuthRepository (AuthLocalRepository)
        Provider<IAuthRepository>(
          create: (context) =>
              AuthLocalRepository(context.read<AuthLocalDataSource>()),
        ),
        Provider<RegisterUseCase>(
          create: (context) => RegisterUseCase(context.read<IAuthRepository>()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            registerUseCase: context.read<RegisterUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            displayLarge: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 39,
              color: Colors.white,
            ),
            bodyLarge: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 12.5,
              color: Colors.white,
            ),
          ),
        ),
        home: const BackgroundImageScreen(),
      ),
    );
  }
}

class BackgroundImageScreen extends StatefulWidget {
  const BackgroundImageScreen({super.key});

  @override
  State<BackgroundImageScreen> createState() => _BackgroundImageScreenState();
}

class _BackgroundImageScreenState extends State<BackgroundImageScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    bool isPortrait = screenHeight > screenWidth;

    double topPadding = isPortrait ? screenHeight * 0.505 : screenHeight * 0.14;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/gettingstarted2.jpeg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: topPadding,
                left: 35,
                right: 35,
                bottom: keyboardHeight + 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: isPortrait
                            ? screenHeight * 0.015
                            : screenHeight * 0.02,
                      ),
                      child: Center(
                        child: Text(
                          'Create an Account',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: 33.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTextField(firstNameController, 'First Name'),
                    const SizedBox(height: 10),
                    _buildTextField(lastNameController, 'Last Name'),
                    const SizedBox(height: 10),
                    _buildTextField(emailController, 'Email'),
                    const SizedBox(height: 10),
                    _buildTextField(passwordController, 'Password',
                        obscureText: true),
                    const SizedBox(height: 10),
                    _buildTextField(
                        confirmPasswordController, 'Confirm Password',
                        obscureText: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<RegisterBloc>().add(
                                RegisterStudent(
                                  context: context,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                ),
                              );     
                        } else {
                          // Show Snackbar if validation fails
                          showMySnackBar(
                            context: context,
                            message: 'Please fill out all fields correctly!',
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
                        'Register',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: GoogleFonts.montserrat(
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
                                  builder: (context) => LoginView(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
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
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return Container(
      height: 35,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label cannot be empty';
          }
          if (label == 'Email' && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          if (label == 'Confirm Password' && value != passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
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
