import 'package:dartz/dartz.dart';
import 'package:music_learning_app/features/chords/domain/entity/chord_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class IChordRepository {
  Future<Either<Failure, List<ChordEntity>>> getSongs({String? instrument});

  Future<Either<Failure, ChordEntity>> getSongById(String id);
}
