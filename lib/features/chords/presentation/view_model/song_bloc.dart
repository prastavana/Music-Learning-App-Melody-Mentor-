// Song Bloc
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_event.dart';
import 'package:music_learning_app/features/chords/presentation/view_model/song_state.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/song_entity.dart';
import '../../domain/use_case/song_usecase.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongsUseCase getAllSongsUseCase;
  final GetSongByIdUseCase getSongByIdUseCase;

  SongBloc({
    required this.getAllSongsUseCase,
    required this.getSongByIdUseCase,
  }) : super(SongInitial()) {
    on<FetchAllSongs>((event, emit) async {
      emit(SongLoading());
      final String? instrument = event.instrument; // Get the instrument

      // Handle null instrument (if needed)
      if (instrument == null) {
        //If no instrument is provided, fetch all songs.
        final Either<Failure, List<SongEntity>> result =
            await getAllSongsUseCase.call(instrument: null);
        result.fold(
          (failure) => emit(SongError(failure.message)),
          (songs) => emit(SongLoaded(songs)),
        );
      } else {
        // Fetch songs by instrument
        final Either<Failure, List<SongEntity>> result =
            await getAllSongsUseCase.call(instrument: instrument);
        result.fold(
          (failure) => emit(SongError(failure.message)),
          (songs) => emit(SongLoaded(songs)),
        );
      }
    });

    on<FetchSongById>((event, emit) async {
      emit(SongLoading());
      if (event.id == null) {
        emit(SongError("Song ID is null"));
        return;
      }
      final Either<Failure, SongEntity> result =
          await getSongByIdUseCase.call(event.id); // Corrected: No need to cast
      result.fold(
        (failure) => emit(SongError(failure.message)),
        (song) => emit(SongDetailLoaded(song)),
      );
    });
  }
}
