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
    print('HiveService: Initializing Hive at path: $path');
    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(SongHiveModelAdapter());
    Hive.registerAdapter(LyricSectionHiveModelAdapter());
    print('HiveService: Adapters registered');

    // Pre-open the song box to ensure it’s ready
    if (!Hive.isBoxOpen(HiveTableConstant.songBox)) {
      await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
      print('HiveService: Song box (${HiveTableConstant.songBox}) pre-opened');
    }
    // Pre-open the student box for auth (if needed)
    if (!Hive.isBoxOpen(HiveTableConstant.studentBox)) {
      await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
      print(
          'HiveService: Student box (${HiveTableConstant.studentBox}) pre-opened');
    }
  }

  // Helper method to get or open the song box
  Future<Box<SongHiveModel>> _getSongBox() async {
    if (!Hive.isBoxOpen(HiveTableConstant.songBox)) {
      print('HiveService: Re-opening song box');
      return await Hive.openBox<SongHiveModel>(HiveTableConstant.songBox);
    }
    return Hive.box<SongHiveModel>(HiveTableConstant.songBox);
  }

  // Helper method to get or open the student box
  Future<Box<AuthHiveModel>> _getStudentBox() async {
    if (!Hive.isBoxOpen(HiveTableConstant.studentBox)) {
      print('HiveService: Re-opening student box');
      return await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    }
    return Hive.box<AuthHiveModel>(HiveTableConstant.studentBox);
  }

  // Auth-related methods
  Future<void> register(AuthHiveModel auth) async {
    var box = await _getStudentBox();
    print('HiveService: Registering auth: ${auth.studentId}');
    await box.put(auth.studentId, auth);
    print('HiveService: Auth registered, box contents: ${box.values.toList()}');
    // Keep box open
  }

  Future<void> deleteAuth(String id) async {
    var box = await _getStudentBox();
    print('HiveService: Deleting auth: $id');
    await box.delete(id);
    print('HiveService: Auth deleted, box contents: ${box.values.toList()}');
    // Keep box open
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await _getStudentBox();
    final authList = box.values.toList();
    print('HiveService: Retrieved auth list: $authList');
    // Keep box open
    return authList;
  }

  Future<AuthHiveModel> login(String email, String password) async {
    var box = await _getStudentBox();
    try {
      final auth = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
      );
      print('HiveService: Login successful for email: $email');
      // Keep box open
      return auth;
    } catch (e) {
      print('HiveService: Login failed: $e');
      throw Exception("Invalid email or password.");
    }
  }

  Future<void> clearAll() async {
    print(
        'HiveService: Clearing all auth data from ${HiveTableConstant.studentBox}');
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    print('HiveService: Closing all boxes');
    await Hive.close();
  }

  // Song-related methods
  Future<List<SongHiveModel>> getAllSongs() async {
    var box = await _getSongBox();
    final songs = box.values.toList();
    print(
        'HiveService: Retrieved all songs from ${HiveTableConstant.songBox}: $songs');
    if (songs.isEmpty) {
      print('HiveService: No songs found in box');
    }
    // Keep box open
    return songs;
  }

  Future<SongHiveModel?> getSongById(String id) async {
    var box = await _getSongBox();
    final song = box.get(id);
    print(
        'HiveService: Retrieved song by ID $id from ${HiveTableConstant.songBox}: $song');
    // Keep box open
    return song;
  }

  Future<void> saveSong(SongHiveModel song) async {
    var box = await _getSongBox();
    print('HiveService: Saving song to ${HiveTableConstant.songBox}: $song');
    await box.put(song.id, song);
    print('HiveService: Song saved, box contents: ${box.values.toList()}');
    // Keep box open
  }

  Future<void> saveSongs(List<SongHiveModel> songs) async {
    var box = await _getSongBox();
    final songMap = {for (var song in songs) song.id: song};
    print(
        'HiveService: Saving multiple songs to ${HiveTableConstant.songBox}: $songMap');
    await box.putAll(songMap);
    print('HiveService: Songs saved, box contents: ${box.values.toList()}');
    // Keep box open
  }

  Future<void> clearSongs() async {
    var box = await _getSongBox();
    print('HiveService: Clearing all songs from ${HiveTableConstant.songBox}');
    await box.clear();
    print('HiveService: Songs cleared, box contents: ${box.values.toList()}');
    // Keep box open
  }

  // Clean shutdown method (call in main.dart if needed)
  Future<void> dispose() async {
    if (Hive.isBoxOpen(HiveTableConstant.songBox)) {
      await Hive.box<SongHiveModel>(HiveTableConstant.songBox).close();
      print('HiveService: Song box closed');
    }
    if (Hive.isBoxOpen(HiveTableConstant.studentBox)) {
      await Hive.box<AuthHiveModel>(HiveTableConstant.studentBox).close();
      print('HiveService: Student box closed');
    }
  }
}
