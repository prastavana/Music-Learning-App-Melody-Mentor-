import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';
import 'package:music_learning_app/features/chords/domain/use_case/song_usecase.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_event.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongsUseCase getAllSongsUseCase;
  final GetSongByIdUseCase getSongByIdUseCase;

  SongBloc({
    required this.getAllSongsUseCase,
    required this.getSongByIdUseCase,
  }) : super(SongInitial()) {
    on<FetchAllSongs>((event, emit) async {
      emit(SongLoading());
      print('SongBloc: Fetching all songs for instrument: ${event.instrument}');
      final Either<Failure, List<SongEntity>> result =
          await getAllSongsUseCase.call(instrument: event.instrument);
      result.fold(
        (failure) {
          print('SongBloc: Fetch Failed: ${failure.message}');
          if (failure is LocalDatabaseFailure &&
              failure.message.contains('No cached data')) {
            emit(SongError(
                'No internet connection and no cached songs available'));
          } else {
            emit(SongError(failure.message));
          }
        },
        (songs) {
          print('SongBloc: Songs Loaded: $songs');
          emit(SongLoaded(songs));
        },
      );
    });

    on<FetchSongById>((event, emit) async {
      emit(SongLoading());
      print('SongBloc: Fetching song by ID: ${event.id}');
      if (event.id.isEmpty) {
        emit(SongError("Song ID is empty"));
        return;
      }
      final Either<Failure, SongEntity> result =
          await getSongByIdUseCase.call(event.id);
      result.fold(
        (failure) {
          print('SongBloc: Fetch Failed: ${failure.message}');
          if (failure is LocalDatabaseFailure &&
              failure.message.contains('Song not found')) {
            emit(SongError('Song not found offline'));
          } else {
            emit(SongError(failure.message));
          }
        },
        (song) {
          print('SongBloc: Song Loaded: $song');
          emit(SongDetailLoaded(song));
        },
      );
    });
  }
}
