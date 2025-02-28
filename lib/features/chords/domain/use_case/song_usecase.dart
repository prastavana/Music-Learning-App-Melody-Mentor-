import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/data_source/song_data_source.dart';
import '../../domain/entity/song_entity.dart';

// Use Case to get a specific song by its ID
class GetSongByIdUseCase {
  final ISongDataSource songDataSource;

  GetSongByIdUseCase({required this.songDataSource});

  Future<Either<Failure, SongEntity>> call(String id) async {
    try {
      final song = await songDataSource.getSongById(id);
      return Right(song);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: e.toString()),
      );
    }
  }
}

// Use Case to get all songs, optionally filtered by instrument
class GetAllSongsUseCase {
  final ISongDataSource songDataSource;

  GetAllSongsUseCase({required this.songDataSource});

  Future<Either<Failure, List<SongEntity>>> call({String? instrument}) async {
    try {
      final songs = await songDataSource.getAllSongs(instrument: instrument);
      return Right(songs);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: e.toString()),
      );
    }
  }
}
