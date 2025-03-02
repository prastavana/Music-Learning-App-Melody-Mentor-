import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF1F0B6F),
              Color(0xFF3C19AA),
              Color(0xFF6929CF),
              Color(0xFFB964E9),
            ],
            stops: [0.35, 0.65, 0.75, 0.85, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 40),
              ListTile(
                leading:
                    const Icon(Icons.person, size: 30, color: Colors.white),
                title: const Text('Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () {
                  // Implement profile navigation
                },
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.brightness_4,
                    size: 30, color: Colors.white),
                title: const Text('Dark Mode',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeCubit.toggleTheme();
                  },
                  activeColor: Colors.purple,
                  activeTrackColor: Colors.purple.shade200,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  thumbColor: MaterialStateProperty.all(Colors.white),
                  trackColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      // Corrected this line
                      if (states.contains(MaterialState.disabled)) {
                        // Corrected this line
                        return null;
                      }
                      if (states.contains(MaterialState.selected)) {
                        // Corrected this line
                        return Colors.purple.shade200;
                      }
                      return Colors.white24;
                    },
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.info, size: 30, color: Colors.white),
                title: const Text('About',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () {
                  // Implement about navigation
                },
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading:
                    const Icon(Icons.logout, size: 30, color: Colors.white),
                title: const Text('Logout',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () {
                  context.read<DashboardCubit>().logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
