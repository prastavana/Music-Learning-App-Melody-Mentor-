import '../entity/note.dart';
import '../repository/tuner_repository.dart';

class GetClosestNoteUseCase {
  final TunerRepository repository;

  GetClosestNoteUseCase(this.repository);

  Note? call(double frequency, String instrument) {
    return repository.getClosestNote(frequency, instrument);
  }
}
