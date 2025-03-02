import '../repository/tuner_repository.dart';

class StartRecordingUseCase {
  final TunerRepository repository;

  StartRecordingUseCase(this.repository);

  Future<void> call() async {
    return repository.startRecording();
  }
}
