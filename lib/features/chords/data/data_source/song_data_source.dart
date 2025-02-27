import '../../domain/entity/song_entity.dart';

abstract interface class ISongDataSource {
  Future<List<SongEntity>> getAllSongs({String? instrument});
  Future<SongEntity> getSongById(String id);
}
