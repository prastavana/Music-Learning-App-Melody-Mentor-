import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/song_entity.dart';

class SongLocalDataSource {
  final HiveService hiveService;

  SongLocalDataSource({required this.hiveService});

  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    try {
      // Fetch the song from Hive using the id
      final songHiveModel = await hiveService.getSongById(id);

      // Convert the SongHiveModel to SongEntity and return it
      if (songHiveModel != null) {
        return Right(songHiveModel.toEntity());
      } else {
        return Left(LocalDatabaseFailure(message: 'Song not found'));
      }
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<Either<Failure, List<SongEntity>>> getAllSongs(
      {String? instrument}) async {
    try {
      // Fetch all songs from Hive
      final songsHiveModels = await hiveService.getAllSongs();

      // If an instrument filter is applied, filter the songs
      final filteredSongs = instrument != null
          ? songsHiveModels
              .where((song) => song.selectedInstrument == instrument)
              .toList()
          : songsHiveModels;

      // Convert the SongHiveModels to SongEntities
      final songEntities =
          filteredSongs.map((song) => song.toEntity()).toList();

      return Right(songEntities);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
