import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view_model/profile/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      BlocProvider.of<ProfileBloc>(context).add(FetchProfileEvent(_token!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return _buildProfile(state.user);
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Loading profile...'));
          }
        },
      ),
    );
  }

  Widget _buildProfile(AuthEntity user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: user.profilePicture != null &&
                      user.profilePicture!.isNotEmpty
                  ? NetworkImage(
                      'http://your-api-base-url/uploads/${user.profilePicture}') // Replace with your actual API base URL and image path
                  : const AssetImage('assets/default_profile.png')
                      as ImageProvider, // Replace with your default asset image path
            ),
          ),
          const SizedBox(height: 20),
          Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('User ID: ${user.userId ?? 'N/A'}',
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
