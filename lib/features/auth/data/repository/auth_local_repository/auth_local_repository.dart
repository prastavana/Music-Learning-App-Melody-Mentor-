import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../data_source/auth_local_data_souce/auth_local_data_source.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, String>> loginStudent(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginStudent(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerStudent(AuthEntity student) async {
    try {
      return Right(_authLocalDataSource.registerStudent(student));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(String token) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
