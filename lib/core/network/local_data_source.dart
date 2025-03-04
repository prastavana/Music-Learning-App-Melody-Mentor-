// core/network/local_data_source.dart
import 'package:music_learning_app/core/network/hive_service.dart';

import '../../features/chords/data/model/song_hive_model.dart';
import 'data_source.dart';

class LocalDataSource<T> implements DataSource<T> {
  final HiveService hiveService;

  LocalDataSource(this.hiveService);

  @override
  Future<T> getRemoteData() async {
    throw UnimplementedError();
  }

  @override
  Future<T> getLocalData() async {
    try {
      if (T == List<SongHiveModel>) {
        return hiveService.getAllSongs() as Future<T>;
      } else {
        throw Exception('Unsupported data type for local data.');
      }
    } catch (e) {
      throw Exception('Failed to load local data: $e');
    }
  }
}
