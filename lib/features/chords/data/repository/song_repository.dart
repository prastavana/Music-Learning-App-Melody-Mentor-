import 'package:dartz/dartz.dart';
import 'package:music_learning_app/core/common/internet_checker/domain/internet_checker.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/features/chords/data/data_source/song_local_data_source/song_local_data_source.dart';
import 'package:music_learning_app/features/chords/data/data_source/song_remote_data_source/song_remote_data_source.dart';
import 'package:music_learning_app/features/chords/domain/entity/song_entity.dart';
import 'package:music_learning_app/features/chords/domain/repository/song_repository.dart';

import '../model/song_hive_model.dart';

class SongRepository implements ISongRepository {
  final SongRemoteDataSource remoteDataSource;
  final SongLocalDataSource localDataSource;
  final InternetChecker internetChecker;

  SongRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.internetChecker,
  });

  @override
  Future<Either<Failure, List<SongEntity>>> getAllSongs(
      {String? instrument}) async {
    final isConnected = await internetChecker.isConnected;
    print('SongRepository: Is Connected: $isConnected');
    if (isConnected) {
      try {
        final songs =
            await remoteDataSource.getAllSongs(instrument: instrument);
        print('SongRepository: Remote Songs Fetched: $songs');
        await localDataSource
            .cacheSongs(songs.map((e) => SongHiveModel.fromEntity(e)).toList());
        return Right(songs);
      } catch (e) {
        print('SongRepository: Remote Fetch Error: $e');
        return Left(ApiFailure(message: 'Failed to fetch songs from API: $e'));
      }
    } else {
      try {
        final cachedSongs =
            await localDataSource.getAllSongs(instrument: instrument);
        print('SongRepository: Cached Songs: $cachedSongs');
        return cachedSongs.fold(
          (failure) => Left(failure),
          (songs) => Right(songs),
        );
      } catch (e) {
        print('SongRepository: Local Fetch Error: $e');
        return Left(
            LocalDatabaseFailure(message: 'Failed to fetch cached songs: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    final isConnected = await internetChecker.isConnected;
    print('SongRepository: Is Connected: $isConnected');
    if (isConnected) {
      try {
        final song = await remoteDataSource.getSongById(id);
        print('SongRepository: Remote Song Fetched: $song');
        await localDataSource.cacheSong(SongHiveModel.fromEntity(song));
        return Right(song);
      } catch (e) {
        print('SongRepository: Remote Fetch Error: $e');
        return Left(ApiFailure(message: 'Failed to fetch song from API: $e'));
      }
    } else {
      try {
        final cachedSong = await localDataSource.getSongById(id);
        print('SongRepository: Cached Song: $cachedSong');
        return cachedSong.fold(
          (failure) => Left(failure),
          (song) => Right(song),
        );
      } catch (e) {
        print('SongRepository: Local Fetch Error: $e');
        return Left(
            LocalDatabaseFailure(message: 'Failed to fetch cached song: $e'));
      }
    }
  }
}
