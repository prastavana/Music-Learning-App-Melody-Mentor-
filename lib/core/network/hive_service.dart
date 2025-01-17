import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/softwarica_student_management.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.put(auth.studentId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    return box.values.toList();
  }

  // Login using email and password
  Future<AuthHiveModel> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    try {
      return box.values.firstWhere(
        (element) => element.email == email && element.password == password,
      );
    } catch (e) {
      throw Exception(
          "Invalid email or password."); // Explicitly throw an exception.
    }
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
