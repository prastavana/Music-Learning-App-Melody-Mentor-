import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_learning_app/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:music_learning_app/features/dashboard/presentation/view_model/dashboard_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/common/internet_checker/data/network_info.dart';
import '../../core/common/internet_checker/data/network_info_impl.dart';
import '../../core/common/internet_checker/domain/internet_checker.dart';
import '../../core/common/internet_checker/presentation/internet_connectivity_cubit.dart';
import '../../core/network/api_service.dart';
import '../../core/network/data_repository.dart';
import '../../core/network/hive_service.dart';
import '../../core/network/local_data_source.dart';
import '../../core/network/remote_data_source.dart';
import '../../core/theme/theme_cubit.dart';
import '../../features/auth/data/data_source/auth_local_data_souce/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/domain/use_case/get_profile_usecase.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/domain/use_case/register_user_usecase.dart';
import '../../features/auth/domain/use_case/upload_image_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/profile/profile_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';
import '../../features/chords/data/data_source/song_data_source.dart';
import '../../features/chords/data/data_source/song_local_data_source/song_local_data_source.dart';
import '../../features/chords/data/data_source/song_remote_data_source/song_remote_data_source.dart';
import '../../features/chords/data/model/song_hive_model.dart';
import '../../features/chords/data/repository/song_local_repository.dart';
import '../../features/chords/data/repository/song_remote_repository.dart';
import '../../features/chords/domain/use_case/song_usecase.dart';
import '../../features/chords/presentation/view_model/song_bloc.dart';
import '../../features/lessons/data/data_source/lesson_data_source.dart';
import '../../features/lessons/data/data_source/lesson_remote_data_source/lesson_remote_datasource.dart';
import '../../features/lessons/data/repository/lesson_remote_repository.dart';
import '../../features/lessons/domain/use_case/get_lesson_usecase.dart';
import '../../features/lessons/presentation/view_model/lesson_bloc.dart';
import '../../features/onboarding/presentation/view_model/onboarding_cubit.dart';
import '../../features/session/data/data_source/session_data_source.dart';
import '../../features/session/data/data_source/session_remote_data_source.dart';
import '../../features/session/data/repository/session_remote_repository.dart';
import '../../features/session/domain/use_case/get_session_usecase.dart';
import '../../features/session/presentation/view_model/session_bloc.dart';
import '../../features/tuner/data/data_source/tuner_local_data_source.dart';
import '../../features/tuner/data/repository/tuner_repository_impl.dart';
import '../../features/tuner/domain/use_case/analyze_frequency_usecase.dart';
import '../../features/tuner/domain/use_case/get_closest_note_usecase.dart';
import '../../features/tuner/domain/use_case/start_recording_usecase.dart';
import '../../features/tuner/domain/use_case/stop_recording_usecase.dart';
import '../../features/tuner/presentation/view_model/tuner_bloc.dart';
import '../shared_prefs/token_shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSongDependencies();
  await _initLessonDependencies();
  await _initSessionDependencies();
  await _initDashboardDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSharedPreferences();
  await _initThemeCubit();
  await _initTunerDependencies();
  await _initNetworkDependencies();
  await _initDataRepository();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  //Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUseCase: getIt(),
    ),
  );
}

_initDashboardDependencies() async {
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );
  // Register GetProfileUseCase
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(
        getIt<AuthRemoteRepository>()), // Register GetProfileUseCase
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      dashboardCubit: getIt<DashboardCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );

  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(getIt<GetProfileUseCase>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

_initSongDependencies() {
  // Register SongRemoteDataSource as ISongDataSource
  getIt.registerLazySingleton<ISongDataSource>(
    () => SongRemoteDataSource(getIt<Dio>()),
  );

  // Register SongLocalDataSource
  getIt.registerLazySingleton<SongLocalDataSource>(
    () => SongLocalDataSource(hiveService: getIt<HiveService>()),
  );

  // Register Remote Repository
  getIt.registerLazySingleton<SongRemoteRepository>(
    () => SongRemoteRepository(
      remoteDataSource: getIt<ISongDataSource>(), // Use ISongDataSource here
    ),
  );

  // Register Local Repository
  getIt.registerLazySingleton<SongLocalRepository>(
    () => SongLocalRepository(
      songLocalDataSource: getIt<SongLocalDataSource>(),
    ),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetAllSongsUseCase>(
    () => GetAllSongsUseCase(
      songDataSource: getIt<ISongDataSource>(), // Use ISongDataSource here
    ),
  );

  getIt.registerLazySingleton<GetSongByIdUseCase>(
    () => GetSongByIdUseCase(
      songDataSource: getIt<ISongDataSource>(), // Use ISongDataSource here
    ),
  );

  // Register SongBloc
  getIt.registerFactory<SongBloc>(
    () => SongBloc(
      getAllSongsUseCase: getIt<GetAllSongsUseCase>(),
      getSongByIdUseCase: getIt<GetSongByIdUseCase>(),
    ),
  );
}

_initThemeCubit() {
  getIt.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(),
  );
}

_initLessonDependencies() {
  getIt.registerLazySingleton<ILessonDataSource>(
    () => LessonRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<LessonRemoteRepository>(
    () => LessonRemoteRepository(
      remoteDataSource: getIt<ILessonDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
      () => GetLessonsUseCase(repository: getIt<LessonRemoteRepository>()));

  getIt.registerFactory(() => LessonBloc(getLessonsUseCase: getIt()));
}

_initSessionDependencies() {
  getIt.registerLazySingleton<ISessionDataSource>(
    () => SessionRemoteDataSource(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<SessionRemoteRepository>(
    () => SessionRemoteRepository(
      remoteDataSource: getIt<ISessionDataSource>(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetSessionsUseCase(repository: getIt<SessionRemoteRepository>()),
  );
  getIt.registerFactory(() => SessionBloc(getSessions: getIt()));
}

_initTunerDependencies() {
  getIt.registerLazySingleton<TunerLocalDataSource>(
      () => TunerLocalDataSource());
  getIt.registerLazySingleton<TunerRepositoryImpl>(
      () => TunerRepositoryImpl(getIt<TunerLocalDataSource>()));

  getIt.registerLazySingleton(
      () => StartRecordingUseCase(getIt<TunerRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => StopRecordingUseCase(getIt<TunerRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => AnalyzeFrequencyUseCase(getIt<TunerRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => GetClosestNoteUseCase(getIt<TunerRepositoryImpl>()));

  getIt.registerFactory(() => TunerBloc(
        startRecordingUseCase: getIt(),
        stopRecordingUseCase: getIt(),
        analyzeFrequencyUseCase: getIt(),
        getClosestNoteUseCase: getIt(),
      ));
}

_initNetworkDependencies() {
  // External Dependencies
  getIt.registerLazySingleton(() => Connectivity());

  // Data Sources
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => InternetChecker(getIt<NetworkInfo>()),
  );

  // Cubits
  getIt.registerFactory(
    () => InternetConnectivityCubit(getIt<InternetChecker>()),
  );
}

_initDataRepository() {
  getIt.registerLazySingleton(
      () => RemoteDataSource<dynamic>(getIt<ApiService>()));
  getIt.registerLazySingleton(
      () => LocalDataSource<List<SongHiveModel>>(getIt<HiveService>()));

  getIt.registerLazySingleton(() => DataRepository<List<SongHiveModel>>(
        getIt<RemoteDataSource<List<SongHiveModel>>>(),
        getIt<InternetChecker>(),
        localDataSource: getIt<LocalDataSource<List<SongHiveModel>>>(),
      ));

  getIt.registerLazySingleton(() => DataRepository<dynamic>(
        getIt<RemoteDataSource<dynamic>>(),
        getIt<InternetChecker>(),
      ));
}
