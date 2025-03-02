import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:music_learning_app/core/error/failure.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../model/auth_api_model.dart';
import '../auth_data_source.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "name": student.name,
          "profilePicture": student.profilePicture,
          "email": student.email,
          "password": student.password,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> loginStudent(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(String token) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await _dio.get(ApiEndpoints.getCurrentUser);

      if (response.statusCode == 200) {
        final authApiModel = AuthApiModel.fromJson(response.data);
        return Right(authApiModel.toEntity());
      } else {
        return Left(
            ApiFailure(message: response.statusMessage ?? "Unknown Error"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(ApiFailure(message: e.response!.data.toString()));
      }
      return Left(ApiFailure(message: e.message ?? "Dio Exception"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
