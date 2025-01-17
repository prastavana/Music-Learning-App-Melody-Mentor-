import 'package:get_it/get_it.dart';
import 'package:music_learning_app/features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import 'package:music_learning_app/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:music_learning_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';

import '../../core/network/hive_service.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_user_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      // LoginBloc: getIt<LoginBloc>(), // Not needed here
    ),
  );
}

_initLoginDependencies() async {
  print("Initializing Login Dependencies...");

  // Registering LoginUseCase
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthLocalRepository>()),
  );

  // Registering LoginBloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      dashboardCubit: getIt<DashboardCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );

  // Check if LoginBloc is correctly registered
  print("LoginBloc Registered: ${getIt.isRegistered<LoginBloc>()}");
}

_initHomeDependencies() async {
  // Register DashboardCubit as a factory
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
