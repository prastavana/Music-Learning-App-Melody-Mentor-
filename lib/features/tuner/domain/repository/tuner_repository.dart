import '../entity/note.dart';

abstract class TunerRepository {
  Future<void> startRecording();
  Future<void> stopRecording();
  Future<double?> analyzeFrequency();
  Note? getClosestNote(double frequency, String instrument);
}
