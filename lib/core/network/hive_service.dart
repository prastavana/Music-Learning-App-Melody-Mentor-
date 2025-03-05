import 'package:hive/hive.dart';
import 'package:music_learning_app/app/constants/hive_table_constant.dart';
import 'package:music_learning_app/features/auth/data/model/auth_hive_model.dart';
import 'package:music_learning_app/features/chords/data/model/song_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/db_melodymentor';
    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(
        LyricSectionHiveModelAdapter()); // Added for LyricSectionHiveModel
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.put(auth.studentId, auth);
    await box.close();
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
    await box.close();
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    final authList = box.values.toList();
    await box.close();
    return authList;
  }

  // Login using email and password
  Future<AuthHiveModel> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    try {
      final auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
      );
      await box.close();
      return auth;
    } catch (e) {
      await box.close();
      throw Exception("Invalid email or password.");
    }
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  // Fetch all songs from Hive
  Future<List<SongHiveModel>> getAllSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final songs = box.values.toList();
    await box.close();
    return songs;
  }

  // Fetch a song by ID from Hive
  Future<SongHiveModel?> getSongById(String id) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final song = box.get(id);
    await box.close();
    return song;
  }

  // Save or update a single song in Hive
  Future<void> saveSong(SongHiveModel song) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.put(song.id, song); // Use song ID as key
    await box.close();
  }

  // Save multiple songs in Hive
  Future<void> saveSongs(List<SongHiveModel> songs) async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    final songMap = {for (var song in songs) song.id: song};
    await box.putAll(songMap);
    await box.close();
  }

  // Clear all songs from Hive
  Future<void> clearSongs() async {
    var box = await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    await box.clear();
    await box.close();
  }
}
