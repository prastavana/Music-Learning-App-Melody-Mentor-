import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:music_learning_app/features/auth/domain/entity/auth_entity.dart';
import 'package:music_learning_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_learning_app/features/auth/domain/use_case/register_user_usecase.dart';

import 'repository.mock.dart';

void main() {
  late RegisterUseCase usecase;
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUseCase(repository);
  });

  final testParams = RegisterUserParams(
    firstName: 'prasta',
    lastName: 'here',
    email: 'prastahere@example.com',
    password: 'prasta123',
    confirmPassword: 'prasta123',
    image: 'profile.jpg',
  );

  final testAuthEntity = AuthEntity(
    firstName: 'prasta',
    lastName: 'here',
    email: 'prastahere@example.com',
    password: 'prasta123',
    confirmPassword: 'prasta123',
    image: 'profile.jpg',
  );

  test(
    'Should call [AuthRepository.registerStudent] and return success when registration is valid',
    () async {
      // Arrange
      when(() => repository.registerStudent(testAuthEntity))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(testParams);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => repository.registerStudent(testAuthEntity)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
