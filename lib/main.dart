import 'package:flutter/cupertino.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/login/login_bloc.dart';

import 'app/app.dart';
import 'app/di/di.dart';
import 'core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Database
  await HiveService.init();

  // Initialize Dependencies
  await initDependencies();

  // Check if LoginBloc is registered
  print("Is LoginBloc registered: ${getIt.isRegistered<LoginBloc>()}");

  // Run the app
  runApp(App());
}
