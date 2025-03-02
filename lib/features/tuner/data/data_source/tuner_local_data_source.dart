import 'dart:io';
import 'dart:typed_data';

import 'package:fftea/fftea.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class TunerLocalDataSource {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  String _audioFilePath = 'recorded_audio.aac';

  Future<void> startRecording() async {
    await Permission.microphone.request();
    await _audioRecorder.openRecorder();
    await _audioRecorder.startRecorder(toFile: _audioFilePath);
  }

  Future<void> stopRecording() async {
    await _audioRecorder.stopRecorder();
    await _audioRecorder.closeRecorder();
  }

  Future<double?> analyzeFrequency() async {
    try {
      File audioFile = File(_audioFilePath);
      Uint8List audioBytes = await audioFile.readAsBytes();
      Float64List audioData = Float64List.view(audioBytes.buffer);

      int sampleRate = 44100;
      int fftSize = 2048;
      var fft = FFT(fftSize);
      var spectrum = fft.realFft(audioData.sublist(0, fftSize));

      double maxMagnitude = 0;
      int maxIndex = 0;
      for (int i = 0; i < spectrum.length; i++) {
        double magnitude = spectrum[i].abs() as double;
        if (magnitude > maxMagnitude) {
          maxMagnitude = magnitude;
          maxIndex = i;
        }
      }

      double frequency = (maxIndex * sampleRate) / fftSize;
      return frequency;
    } catch (e) {
      print("Error analyzing frequency: $e");
      return null;
    }
  }

  double? getNote(double frequency, String instrument) {
    List<double> targetFrequencies;
    List<String> noteNames;

    if (instrument == 'guitar') {
      targetFrequencies = [82.41, 110.00, 146.83, 195.99, 246.94, 329.63];
      noteNames = ['E2', 'A2', 'D3', 'G3', 'B3', 'E4'];
    } else if (instrument == 'ukulele') {
      targetFrequencies = [261.63, 392.00, 329.63, 440.00];
      noteNames = ['C4', 'G4', 'E4', 'A4'];
    } else {
      return null;
    }

    double minDiff = double.infinity;
    double? closestFrequency;

    for (double targetFreq in targetFrequencies) {
      double diff = (frequency - targetFreq).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestFrequency = targetFreq;
      }
    }

    return closestFrequency;
  }
}
