import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_model/login/login_bloc.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/gettingstarted2.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Form and UI
          const BackgroundImageScreen(),
        ],
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _img;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);

          context.read<RegisterBloc>().add(
                LoadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final isPortrait = screenHeight > screenWidth;

    final topPadding = isPortrait ? screenHeight * 0.505 : screenHeight * 0.14;

    return SingleChildScrollView(
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipOval(
                      child: _img != null
                          ? Image.file(
                              _img!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                          : Image.asset(
                              'assets/images/profile.png', // Your default avatar
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  'Create an Account',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 33.5,
                    color: Colors.white,
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
              _buildTextField(confirmPasswordController, 'Confirm Password',
                  obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final registerState = context.read<RegisterBloc>().state;
                    final imageName = registerState.imageName;
                    context.read<RegisterBloc>().add(
                          RegisterStudent(
                            context: context,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            image: imageName,
                          ),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill out all fields correctly!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                  ),
                  backgroundColor: const Color(0xFF8FFCFF).withOpacity(0.56),
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
                            builder: (context) => BlocProvider<LoginBloc>(
                              create: (_) => context.read<LoginBloc>(),
                              child: LoginView(),
                            ),
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
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return TextFormField(
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
    );
  }
}
