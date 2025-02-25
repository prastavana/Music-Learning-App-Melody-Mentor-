import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/features/auth/domain/entity/auth_entity.dart';
import 'package:music_learning_app/features/auth/domain/use_case/register_user_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity(
      name: '',
      email: '',
      password: '',
    ));
  });

  const registerParams = RegisterUserParams(
    name: "prasta",
    email: "prasta@gmail.com",
    password: "prasta123",
  );

  group('RegisterUseCase Tests', () {
    test('should return Failure when email is already in use', () async {
      // Arrange
      when(() => repository.registerStudent(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email is already registered")));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "Email is already registered")));
      verify(() => repository.registerStudent(any())).called(1);
    });

    test('should return Failure when required fields are missing', () async {
      // Arrange
      final invalidParams = RegisterUserParams(
        name: "",
        email: "prasta@gmail.com",
        password: "prasta123",
      );

      when(() => repository.registerStudent(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "One or more credentials are empty")));

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "One or more credentials are empty")));
      verify(() => repository.registerStudent(any())).called(1);
    });

    test('should return Failure when there is Api Failure', () async {
      // Arrange
      when(() => repository.registerStudent(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Unexpected server error")));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Unexpected server error")));
      verify(() => repository.registerStudent(any())).called(1);
    });

    test('should successfully register a user and return Right(null)',
        () async {
      // Arrange
      when(() => repository.registerStudent(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerStudent(any())).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return Failure when passwords do not match', () async {
      // Arrange
      final mismatchedParams = RegisterUserParams(
        name: "prasta",
        email: "prasta@gmail.com",
        password: "prasta123",
      );

      when(() => repository.registerStudent(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Passwords do not match")));

      // Act
      final result = await useCase(mismatchedParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Passwords do not match")));
      verify(() => repository.registerStudent(any())).called(1);
    });
  });
}
