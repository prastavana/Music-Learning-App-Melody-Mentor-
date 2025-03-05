import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_learning_app/core/common/internet_checker/data/network_info.dart';
import 'package:music_learning_app/core/common/internet_checker/domain/internet_checker.dart';
import 'package:music_learning_app/core/network/api_service.dart';
import 'package:music_learning_app/core/network/hive_service.dart';
import 'package:music_learning_app/core/theme/theme_cubit.dart';
import 'package:music_learning_app/features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import 'package:music_learning_app/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:music_learning_app/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:music_learning_app/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:music_learning_app/features/auth/domain/use_case/get_profile_usecase.dart';
import 'package:music_learning_app/features/auth/domain/use_case/login_usecase.dart';
import 'package:music_learning_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:music_learning_app/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/profile/profile_bloc.dart';
import 'package:music_learning_app/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:music_learning_app/features/chords/data/data_source/song_local_data_source/song_local_data_source.dart';
import 'package:music_learning_app/features/chords/data/data_source/song_remote_data_source/song_remote_data_source.dart';
import 'package:music_learning_app/features/chords/data/repository/song_local_repository.dart';
import 'package:music_learning_app/features/chords/data/repository/song_remote_repository.dart';
import 'package:music_learning_app/features/chords/data/repository/song_repository.dart';
import 'package:music_learning_app/features/chords/domain/use_case/song_usecase.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_bloc.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:music_learning_app/features/lessons/data/data_source/lesson_data_source.dart';
import 'package:music_learning_app/features/lessons/data/data_source/lesson_remote_data_source/lesson_remote_datasource.dart';
import 'package:music_learning_app/features/lessons/data/repository/lesson_remote_repository.dart';
import 'package:music_learning_app/features/lessons/domain/use_case/get_lesson_usecase.dart';
import 'package:music_learning_app/features/lessons/presentation/view_model/lesson_bloc.dart';
import 'package:music_learning_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:music_learning_app/features/session/data/data_source/session_data_source.dart';
import 'package:music_learning_app/features/session/data/data_source/session_remote_data_source.dart';
import 'package:music_learning_app/features/session/data/repository/session_remote_repository.dart';
import 'package:music_learning_app/features/session/domain/use_case/get_session_usecase.dart';
import 'package:music_learning_app/features/session/presentation/view_model/session_bloc.dart';
import 'package:music_learning_app/features/tuner/presentation/view_model/tuner/tuner_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/common/internet_checker/data/network_info_impl.dart';
import '../../features/chords/domain/repository/song_repository.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initNetworkDependencies();
  await _initSongDependencies();
  await _initLessonDependencies();
  await _initSessionDependencies();
  await _initDashboardDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSharedPreferences();
  await _initThemeCubit();
  await _initTunerDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initNetworkDependencies() async {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<Connectivity>()));
  getIt.registerLazySingleton<InternetChecker>(
      () => InternetChecker(getIt<NetworkInfo>()));
}

_initRegisterDependencies() {
  getIt.registerLazySingleton(() => AuthLocalDataSource(getIt<HiveService>()));
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton(
      () => AuthLocalRepository(getIt<AuthLocalDataSource>()));
  getIt.registerLazySingleton(
      () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()));
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRemoteRepository>()));
  getIt.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(getIt<AuthRemoteRepository>()));
  getIt.registerFactory<RegisterBloc>(() =>
      RegisterBloc(registerUseCase: getIt(), uploadImageUseCase: getIt()));
}

_initDashboardDependencies() async {
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
      () => TokenSharedPrefs(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<LoginUseCase>(() =>
      LoginUseCase(getIt<AuthRemoteRepository>(), getIt<TokenSharedPrefs>()));
  getIt.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(getIt<AuthRemoteRepository>()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        registerBloc: getIt<RegisterBloc>(),
        dashboardCubit: getIt<DashboardCubit>(),
        loginUseCase: getIt<LoginUseCase>(),
      ));
  getIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(getIt<GetProfileUseCase>()));
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(getIt<LoginBloc>()));
}

_initSongDependencies() {
  getIt.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton<SongLocalDataSource>(
      () => SongLocalDataSource(hiveService: getIt<HiveService>()));
  getIt.registerLazySingleton<SongRemoteRepository>(() =>
      SongRemoteRepository(remoteDataSource: getIt<SongRemoteDataSource>()));
  getIt.registerLazySingleton<SongLocalRepository>(() =>
      SongLocalRepository(songLocalDataSource: getIt<SongLocalDataSource>()));
  getIt.registerLazySingleton<ISongRepository>(() => SongRepository(
        remoteDataSource: getIt<SongRemoteDataSource>(),
        localDataSource: getIt<SongLocalDataSource>(),
        internetChecker: getIt<InternetChecker>(),
      ));
  getIt.registerLazySingleton<GetAllSongsUseCase>(
      () => GetAllSongsUseCase(repository: getIt<ISongRepository>()));
  getIt.registerLazySingleton<GetSongByIdUseCase>(
      () => GetSongByIdUseCase(repository: getIt<ISongRepository>()));
  getIt.registerFactory<SongBloc>(() => SongBloc(
        getAllSongsUseCase: getIt<GetAllSongsUseCase>(),
        getSongByIdUseCase: getIt<GetSongByIdUseCase>(),
      ));
}

_initThemeCubit() {
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

_initLessonDependencies() {
  getIt.registerLazySingleton<ILessonDataSource>(
      () => LessonRemoteDataSource(getIt<Dio>()));
  getIt.registerLazySingleton<LessonRemoteRepository>(() =>
      LessonRemoteRepository(remoteDataSource: getIt<ILessonDataSource>()));
  getIt.registerLazySingleton(
      () => GetLessonsUseCase(repository: getIt<LessonRemoteRepository>()));
  getIt.registerFactory(() => LessonBloc(getLessonsUseCase: getIt()));
}

_initSessionDependencies() {
  getIt.registerLazySingleton<ISessionDataSource>(
      () => SessionRemoteDataSource(dio: getIt<Dio>()));
  getIt.registerLazySingleton<SessionRemoteRepository>(() =>
      SessionRemoteRepository(remoteDataSource: getIt<ISessionDataSource>()));
  getIt.registerLazySingleton(
      () => GetSessionsUseCase(repository: getIt<SessionRemoteRepository>()));
  getIt.registerFactory(() => SessionBloc(getSessions: getIt()));
}

_initTunerDependencies() {
  getIt.registerFactory<TunerBloc>(() => TunerBloc());
}
