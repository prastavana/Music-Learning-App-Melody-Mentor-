import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart'; // Other blocs
import 'package:music_learning_app/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:music_learning_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/view_model/login/login_bloc.dart';
import 'di/di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingCubit>(
            create: (context) => getIt<OnboardingCubit>(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) {
              // Make sure that LoginBloc is registered properly
              final loginBloc = getIt<LoginBloc>();

              if (loginBloc == null) {
                print("LoginBloc is null! Please check the registration.");
                throw Exception("LoginBloc is not registered properly");
              }

              return loginBloc;
            },
          ),
          BlocProvider<DashboardCubit>(
            create: (context) => getIt<DashboardCubit>(),
          ),
        ],
        child: OnboardingView(),
      ),
    );
  }
}
