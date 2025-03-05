import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';
import 'package:music_learning_app/features/chords/domain/repository/song_repository.dart';

class GetSongByIdUseCase {
  final ISongRepository repository;
  GetSongByIdUseCase({required this.repository});
  Future<Either<Failure, SongEntity>> call(String id) async {
    return await repository.getSongById(id);
  }
}

class GetAllSongsUseCase {
  final ISongRepository repository;
  GetAllSongsUseCase({required this.repository});
  Future<Either<Failure, List<SongEntity>>> call({String? instrument}) async {
    return await repository.getAllSongs(instrument: instrument);
  }
}
