// auth_data_source.dart
import 'dart:io';

import 'package:dartz/dartz.dart'; // Import Either

import '../../../../core/error/failure.dart'; // Import Failure
import '../../domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<void> registerStudent(AuthEntity student);

  Future<Either<Failure, AuthEntity>> getCurrentUser(
      String token); // Updated return type

  Future<String> loginStudent(String email, String password);

  Future<String> uploadProfilePicture(File file);
}
