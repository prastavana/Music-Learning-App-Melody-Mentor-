import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';
import '../../../chords/presentation/view/song_view.dart';
import '../../../chords/presentation/view_model/song_bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }

  void navigateToSongView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt<SongBloc>(), // Pass the SongBloc here
          child: SongView(), // Navigate to SongView
        ),
      ),
    );
  }
}
