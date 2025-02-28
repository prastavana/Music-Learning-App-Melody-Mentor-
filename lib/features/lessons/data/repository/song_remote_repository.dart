import '../data_source/lesson_remote_data_source/lesson_remote_datasource.dart';

class RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepository({required this.remoteDataSource});

  Future<List<LessonEntity>> getLessons() async {
    final apiModels = await remoteDataSource.getLessons();
    return apiModels
        .map((apiModel) => LessonEntity(
              id: apiModel.id,
              day: apiModel.day,
              instrument: apiModel.instrument,
              quizzes: apiModel.quizzes
                  .map((quizApiModel) => QuizEntity(
                        question: quizApiModel.question,
                        options: quizApiModel.options,
                        correctAnswer: quizApiModel.correctAnswer,
                        chordDiagram: quizApiModel.chordDiagram,
                      ))
                  .toList(),
            ))
        .toList();
  }
}
