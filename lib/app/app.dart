import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/lessons/presentation/view/lesson_view.dart';
import 'package:music_learning_app/features/lessons/presentation/view_model/lesson_bloc.dart';
import 'package:provider/provider.dart';

import '../core/theme/theme_cubit.dart';
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
          BlocProvider(
            create: (_) => getIt<LoginBloc>(),
          ),
          BlocProvider(
            create: (_) => getIt<DashboardCubit>(),
          ),
          BlocProvider(
            create: (_) =>
                getIt<SongBloc>(), // Ensure SongBloc is provided here
          ),
          BlocProvider(
            create: (_) =>
                getIt<LessonBloc>(), // Ensure SongBloc is provided here
          ),
          BlocProvider(create: (_) => getIt<ThemeCubit>()),
        ],
        child: LessonView(), // Ensure DashboardView is a descendant
      ),
    );
  }
}
