import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';
import 'package:music_learning_app/features/auth/presentation/view/profile_view.dart'; // Import ProfileView
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
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
              leading: const Icon(Icons.person, size: 30, color: Colors.white),
              title: const Text('Profile',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                // Navigate to ProfileView
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                );
              },
            ),
            const Divider(color: Colors.white24),
            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, themeData) {
                final isDarkMode = themeData.brightness == Brightness.dark;
                print("SettingsView BlocBuilder: isDarkMode = $isDarkMode");
                print(
                    "SettingsView BlocBuilder: scaffoldBackgroundColor = ${themeData.scaffoldBackgroundColor}");
                return SwitchListTile(
                  title: const Text('Dark Mode',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  secondary: const Icon(Icons.dark_mode,
                      size: 30, color: Colors.white),
                  value: isDarkMode,
                  onChanged: (value) {
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
                      return Colors.white24;
                    },
                  ),
                );
              },
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
              leading: const Icon(Icons.logout, size: 30, color: Colors.white),
              title: const Text('Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                context.read<DashboardCubit>().logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
