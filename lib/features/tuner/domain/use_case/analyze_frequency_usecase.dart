import '../repository/tuner_repository.dart';

class AnalyzeFrequencyUseCase {
  final TunerRepository repository;

  AnalyzeFrequencyUseCase(this.repository);

  Future<double?> call() async {
    return repository.analyzeFrequency();
  }
}
