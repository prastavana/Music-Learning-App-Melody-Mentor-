import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:music_learning_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_learning_app/features/auth/domain/use_case/register_user_usecase.dart';

import 'repository.mock.dart';

// Mock Repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase usecase;
  late MockAuthRepository repository;

  setUpAll(() {
    // Register fallback value for `RegisterUserParams`
    registerFallbackValue(RegisterUserParams(
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      confirmPassword: '',
      image: '',
    ));
  });

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

  test(
    'Should call [AuthRepository.registerStudent] and return success when registration is valid',
    () async {
      // Arrange: Use captureAny() instead of any() if needed
      when(() => repository.registerStudent(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(testParams);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => repository.registerStudent(any())).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
