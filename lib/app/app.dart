// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/theme/app_theme.dart';
import 'package:music_learning_app/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:music_learning_app/features/tuner/presentation/view_model/tuner/tuner_bloc.dart';
import 'package:provider/provider.dart';

import '../core/theme/theme_cubit.dart';
import '../features/auth/presentation/view_model/login/login_bloc.dart';
import '../features/auth/presentation/view_model/profile/profile_bloc.dart';
import '../features/chords/presentation/view_model/song_bloc.dart';
import '../features/dashboard/presentation/view_model/dashboard_cubit.dart';
import '../features/lessons/presentation/view_model/lesson_bloc.dart';
import '../features/session/presentation/view_model/session_bloc.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Start shake detection when the app is running

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<DashboardCubit>()),
        BlocProvider(create: (_) => getIt<SongBloc>()),
        BlocProvider(create: (_) => getIt<LessonBloc>()),
        BlocProvider(create: (_) => getIt<SessionBloc>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<ProfileBloc>()),
        BlocProvider(create: (_) => getIt<TunerBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        // Make sure this is here
        builder: (context, themeData) {
          print("App BlocBuilder: brightness = ${themeData.brightness}");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Melody Mentor',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeData.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: DashboardView(),
          );
        },
      ),
    );
  }
}
