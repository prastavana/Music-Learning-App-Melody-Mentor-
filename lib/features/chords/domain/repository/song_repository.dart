import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/song_entity.dart';

abstract interface class ISongRepository {
  Future<Either<Failure, SongEntity>> getSongById(String id);
  Future<Either<Failure, List<SongEntity>>> getAllSongs({String? instrument});
}
