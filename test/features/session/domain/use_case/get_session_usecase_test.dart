import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_learning_app/core/error/failure.dart';
import 'package:music_learning_app/features/session/domain/entity/session_entity.dart';
import 'package:music_learning_app/features/session/domain/repository/session_repository.dart';
import 'package:music_learning_app/features/session/domain/use_case/get_session_usecase.dart';

// Your provided mock for Session
class MockSessionRepository extends Mock implements ISessionRepository {}

void main() {
  group('GetSessionsUseCase Tests', () {
    late GetSessionsUseCase usecase;
    late MockSessionRepository mockSessionRepository;

    setUp(() {
      mockSessionRepository = MockSessionRepository();
      usecase = GetSessionsUseCase(repository: mockSessionRepository);
    });

    final tSessions = [
      SessionEntity(
        id: '1',
        instrument: 'Guitar',
        day: '1',
        title: 'Guitar Session 1',
        description: 'Practice chords',
        duration: 30,
        instructions: 'Follow the instructions',
        file: null,
      ),
      SessionEntity(
        id: '2',
        instrument: 'Piano',
        day: '2',
        title: 'Piano Session 1',
        description: 'Scales and arpeggios',
        duration: 60,
        instructions: 'Follow the instructions',
        file: null,
      ),
    ];

    test('should get all sessions from the repository', () async {
      when(() => mockSessionRepository.getAllSessions(instrument: null))
          .thenAnswer((_) async => Right(tSessions));

      final result = await usecase.call();

      expect(result, Right(tSessions));
      verify(() => mockSessionRepository.getAllSessions(instrument: null))
          .called(1);
      verifyNoMoreInteractions(mockSessionRepository);
    });

    test('should return a Failure when the repository returns a Failure',
        () async {
      const failure = ApiFailure(message: 'Test Failure');
      when(() => mockSessionRepository.getAllSessions(instrument: null))
          .thenAnswer((_) async => const Left(failure));

      final result = await usecase.call();

      expect(result, const Left(failure));
      verify(() => mockSessionRepository.getAllSessions(instrument: null))
          .called(1);
      verifyNoMoreInteractions(mockSessionRepository);
    });
  });
}
