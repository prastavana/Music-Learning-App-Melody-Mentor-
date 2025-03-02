import '../repository/tuner_repository.dart';

class StopRecordingUseCase {
  final TunerRepository repository;

  StopRecordingUseCase(this.repository);

  Future<void> call() async {
    return repository.stopRecording();
  }
}
