import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/song_entity.dart';
import '../../domain/repository/song_repository.dart';
import '../data_source/song_data_source.dart';

class SongRemoteRepository implements ISongRepository {
  final ISongDataSource remoteDataSource;

  SongRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, SongEntity>> getSongById(String id) async {
    try {
      final song = await remoteDataSource.getSongById(id);
      return Right(song); // Return the song if the fetch is successful
    } catch (e) {
      return Left(ApiFailure(
          message: e.toString())); // Return an error in case of failure
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getAllSongs(
      {String? instrument}) async {
    try {
      final songs = await remoteDataSource.getAllSongs(instrument: instrument);
      return Right(
          songs); // Return the list of songs if the fetch is successful
    } catch (e) {
      return Left(ApiFailure(
          message: e.toString())); // Return an error in case of failure
    }
  }
}
