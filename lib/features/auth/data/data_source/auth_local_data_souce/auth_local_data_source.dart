// auth_local_data_source.dart
import 'dart:io';

import 'package:dartz/dartz.dart'; // Import Either

import '../../../../../core/error/failure.dart'; // Import Failure
import '../../../../../core/network/hive_service.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../model/auth_hive_model.dart';
import '../auth_data_source.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  @override
  Future<String> loginStudent(String email, String password) async {
    try {
      await _hiveService.login(email, password);
      return "Success";
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(String token) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
