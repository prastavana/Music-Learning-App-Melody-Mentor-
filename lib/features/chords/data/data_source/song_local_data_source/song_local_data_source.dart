import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/core/network/hive_service.dart';
import 'package:music_learning_app/features/chords/data/model/song_hive_model.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';

class SongLocalDataSource {
  final HiveService hiveService;

  SongLocalDataSource({required this.hiveService});

  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    try {
      final songHiveModel = await hiveService.getSongById(id);
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
      final songsHiveModels = await hiveService.getAllSongs();
      final filteredSongs = instrument != null
          ? songsHiveModels
              .where((song) => song.selectedInstrument == instrument)
              .toList()
          : songsHiveModels;
      final songEntities =
          filteredSongs.map((song) => song.toEntity()).toList();
      return Right(songEntities);
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> cacheSongs(List<SongHiveModel> songs) async {
    try {
      await hiveService.clearSongs(); // Clear existing songs
      await hiveService.saveSongs(songs); // Save new songs
    } catch (e) {
      throw Exception('Failed to cache songs: $e');
    }
  }

  Future<void> cacheSong(SongHiveModel song) async {
    try {
      await hiveService.saveSong(song); // Save or update single song
    } catch (e) {
      throw Exception('Failed to cache song: $e');
    }
  }
}
