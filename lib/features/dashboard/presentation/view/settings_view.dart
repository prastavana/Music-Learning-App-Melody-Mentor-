import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/app_theme.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';
import 'package:music_learning_app/core/utils/gyroscope_sensor_service.dart';
import 'package:music_learning_app/features/auth/presentation/view/profile_view.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late GyroscopeSensorService _gyroscopeService;
  bool _isAutoThemeEnabled = false;
  bool _isLightTheme = false;
  bool _themeToggled = false; // Added state variable

  @override
  void initState() {
    super.initState();
    _gyroscopeService = GyroscopeSensorService(
      onTiltChanged: (rotationX, rotationY) {
        if (_isAutoThemeEnabled) {
          double angle = atan2(rotationX, rotationY) * (180 / pi);

          // Check for a left tilt between 0 and 70 degrees
          if (angle.round() <= 0 && angle.round() >= -70) {
            if (!_themeToggled) {
              // Check if theme has already been toggled
              if (_isLightTheme) {
                context.read<ThemeCubit>().emit(AppTheme.darkTheme);
              } else {
                context.read<ThemeCubit>().emit(AppTheme.lightTheme);
              }
              setState(() {
                _isLightTheme = !_isLightTheme;
                _themeToggled = true; // Set theme toggled to true
              });
            }
          } else {
            setState(() {
              _themeToggled = false; // Reset theme toggled when out of range
            });
          }
        }
      },
    );
    _gyroscopeService.startListening();
  }

  @override
  void dispose() {
    _gyroscopeService.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, themeData) {
        final isDarkMode = themeData.brightness == Brightness.dark;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeData.colorScheme.primary,
                  themeData.colorScheme.secondary,
                  themeData.colorScheme.tertiary,
                  themeData.colorScheme.surface,
                  themeData.colorScheme.background,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, themeData) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: isDarkMode
                            ? themeData.scaffoldBackgroundColor
                            : Colors.grey[200],
                        child: const Icon(Icons.person, size: 50),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  ListTile(
                    leading: Icon(Icons.person,
                        size: 30, color: themeData.iconTheme.color),
                    title: Text('Profile',
                        style: TextStyle(
                            color: themeData.textTheme.bodyMedium?.color,
                            fontSize: 18)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileView()),
                      );
                    },
                  ),
                  BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, themeData) {
                      return Divider(color: themeData.dividerColor);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Auto Theme (Gyroscope)'),
                    value: _isAutoThemeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isAutoThemeEnabled = value;
                        if (!value) {
                          _isLightTheme = false;
                          _themeToggled = false;
                        }
                      });
                    },
                  ),
                  BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, themeData) {
                      final isDarkMode =
                          themeData.brightness == Brightness.dark;
                      return SwitchListTile(
                        title: Text(isDarkMode ? 'Dark Mode' : 'Light Mode',
                            style: TextStyle(
                                color: themeData.textTheme.bodyMedium?.color,
                                fontSize: 18)),
                        secondary: Icon(Icons.dark_mode,
                            size: 30, color: themeData.iconTheme.color),
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            _isAutoThemeEnabled = false;
                            _isLightTheme = false;
                            _themeToggled = false;
                          });
                          themeCubit.toggleTheme();
                        },
                        activeColor: Colors.purple,
                        activeTrackColor: Colors.purple.shade200,
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        trackColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return null;
                            }
                            if (states.contains(MaterialState.selected)) {
                              return Colors.purple.shade200;
                            }
                            return isDarkMode
                                ? themeData.scaffoldBackgroundColor
                                : Colors.grey[200];
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, themeData) {
                      return Divider(color: themeData.dividerColor);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info,
                        size: 30, color: themeData.iconTheme.color),
                    title: Text('About',
                        style: TextStyle(
                            color: themeData.textTheme.bodyMedium?.color,
                            fontSize: 18)),
                    onTap: () {
                      // Implement about navigation
                    },
                  ),
                  BlocBuilder<ThemeCubit, ThemeData>(
                    builder: (context, themeData) {
                      return Divider(color: themeData.dividerColor);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout,
                        size: 30, color: themeData.iconTheme.color),
                    title: Text('Logout',
                        style: TextStyle(
                            color: themeData.textTheme.bodyMedium?.color,
                            fontSize: 18)),
                    onTap: () {
                      context.read<DashboardCubit>().logout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
