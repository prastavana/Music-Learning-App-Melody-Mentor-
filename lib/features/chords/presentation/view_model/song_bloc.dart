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
      final Either<Failure, List<SongEntity>> result =
          await getAllSongsUseCase.call(instrument: event?.instrument);
      result.fold(
        (failure) => emit(SongError(failure.message)),
        (songs) => emit(SongLoaded(songs)),
      );
    });

    on<FetchSongById>((event, emit) async {
      emit(SongLoading());
      final Either<Failure, SongEntity> result =
          await getSongByIdUseCase.call(event.id as String);
      result.fold(
        (failure) => emit(SongError(failure.message)),
        (song) => emit(SongDetailLoaded(song)),
      );
    });
  }
}
