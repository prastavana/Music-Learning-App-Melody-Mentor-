import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/core/network/hive_service.dart';
import 'package:music_learning_app/features/chords/data/model/song_hive_model.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';

class SongLocalDataSource {
  final HiveService hiveService;

  SongLocalDataSource({required this.hiveService});

  Future<Either<Failure, List<SongEntity>>> getAllSongs(
      {String? instrument}) async {
    try {
      final songsHiveModels = await hiveService.getAllSongs();
      print('SongLocalDataSource: Raw Hive Songs: $songsHiveModels');
      if (songsHiveModels.isEmpty) {
        print('SongLocalDataSource: No songs in Hive');
        return Right(
            []); // Return empty list instead of failure for consistency
      }
      final filteredSongs = instrument != null
          ? songsHiveModels.where((song) {
              final matches = (song.selectedInstrument ?? '').toLowerCase() ==
                  instrument.toLowerCase();
              print(
                  'SongLocalDataSource: Song ${song.songName} matches $instrument: $matches');
              return matches;
            }).toList()
          : songsHiveModels;
      print(
          'SongLocalDataSource: Filtered Songs for $instrument: $filteredSongs');
      final songEntities =
          filteredSongs.map((song) => song.toEntity()).toList();
      return Right(songEntities);
    } catch (e) {
      print('SongLocalDataSource: Error fetching songs: $e');
      return Left(
          LocalDatabaseFailure(message: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    try {
      final songHiveModel = await hiveService.getSongById(id);
      print('SongLocalDataSource: Song by ID $id: $songHiveModel');
      if (songHiveModel != null) {
        return Right(songHiveModel.toEntity());
      } else {
        return Left(LocalDatabaseFailure(message: 'Song not found'));
      }
    } catch (e) {
      print('SongLocalDataSource: Error fetching song by ID: $e');
      return Left(
          LocalDatabaseFailure(message: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> cacheSongs(List<SongHiveModel> songs) async {
    try {
      await hiveService.clearSongs();
      await hiveService.saveSongs(songs);
      print('SongLocalDataSource: Cached Songs: $songs');
      final cached = await hiveService.getAllSongs();
      print('SongLocalDataSource: Verified Cached Songs: $cached');
    } catch (e) {
      print('SongLocalDataSource: Error caching songs: $e');
      throw Exception('Failed to cache songs: $e');
    }
  }

  Future<void> cacheSong(SongHiveModel song) async {
    try {
      await hiveService.saveSong(song);
      print('SongLocalDataSource: Cached Song: $song');
    } catch (e) {
      print('SongLocalDataSource: Error caching song: $e');
      throw Exception('Failed to cache song: $e');
    }
  }
}
