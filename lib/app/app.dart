import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view/song_view.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/view_model/login/login_bloc.dart';
import '../features/chords/presentation/view_model/song_bloc.dart';
import '../features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melody Mentor',
      home: MultiProvider(
        providers: [
          // Provide LoginBloc using BlocProvider.create to ensure proper lifecycle management
          BlocProvider(
            create: (_) => getIt<LoginBloc>(),
          ),
          BlocProvider(
            create: (_) => getIt<DashboardCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<SongBloc>(),
          ),
        ],
        child: SongView(),
      ),
    );
  }
}
