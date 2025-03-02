import '../../domain/entity/note.dart';
import '../../domain/repository/tuner_repository.dart';
import '../data_source/tuner_local_data_source.dart';
import '../model/model_data.dart';

class TunerRepositoryImpl implements TunerRepository {
  final TunerLocalDataSource dataSource;

  TunerRepositoryImpl(this.dataSource);

  @override
  Future<void> startRecording() async {
    return dataSource.startRecording();
  }

  @override
  Future<void> stopRecording() async {
    return dataSource.stopRecording();
  }

  @override
  Future<double?> analyzeFrequency() async {
    return dataSource.analyzeFrequency();
  }

  @override
  Note? getClosestNote(double frequency, String instrument) {
    double? closestFrequency = dataSource.getNote(frequency, instrument);
    if (closestFrequency == null) {
      return null;
    }
    return NoteModel(frequency: closestFrequency, name: "")
        .toEntity(); // Add logic to get note name.
  }
}
