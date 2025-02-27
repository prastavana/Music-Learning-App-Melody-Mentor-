import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/song_entity.dart';
import '../../domain/repository/song_repository.dart';
import '../data_source/song_local_data_source/song_local_data_source.dart';

class SongLocalRepository implements ISongRepository {
  final SongLocalDataSource _songLocalDataSource;

  SongLocalRepository({required SongLocalDataSource songLocalDataSource})
      : _songLocalDataSource = songLocalDataSource;

  @override
  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    try {
      final result = await _songLocalDataSource.getSongById(id);
      return result; // Return as it is, no need to modify here
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: e.toString())); // Handle failure
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getAllSongs(
      {String? instrument}) async {
    try {
      final result =
          await _songLocalDataSource.getAllSongs(instrument: instrument);
      return result; // Return as it is, no need to modify here
    } catch (e) {
      return Left(
          LocalDatabaseFailure(message: e.toString())); // Handle failure
    }
  }
}
