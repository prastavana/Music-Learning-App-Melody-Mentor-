import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tuner_event.dart';
part 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  TunerBloc() : super(TunerInitial()) {
    on<StartRecordingEvent>(_onStartRecording);
    on<StopRecordingEvent>(_onStopRecording);
  }

  StreamSubscription<double>? _audioStreamSubscription;
  double _lastFrequency = 0.0;

  Future<void> _onStartRecording(
      StartRecordingEvent event, Emitter<TunerState> emit) async {
    // Simulate audio input and frequency calculation. Replace with actual audio processing.
    _audioStreamSubscription =
        Stream.periodic(const Duration(milliseconds: 50), (count) {
      // Simulate frequency change.
      final random = Random();
      _lastFrequency = 440.0 + random.nextDouble() * 20 - 10;
      return _lastFrequency;
    }).listen((frequency) {
      final note = _getNoteFromFrequency(frequency);
      final status = _getTuningStatus(frequency, note);
      final gaugeValue = _calculateGaugeValue(frequency, note);
      emit(RecordingState(
          note: note,
          status: status,
          frequency: frequency,
          gaugeValue: gaugeValue));
    });
  }

  Future<void> _onStopRecording(
      StopRecordingEvent event, Emitter<TunerState> emit) async {
    await _audioStreamSubscription?.cancel();
    emit(NotRecordingState());
  }

  String _getNoteFromFrequency(double frequency) {
    // Simplified note detection. Replace with accurate algorithm.
    if (frequency >= 435 && frequency <= 445) {
      return 'A4';
    } else if (frequency >= 260 && frequency <= 264) {
      return 'C4';
    } else if (frequency >= 328 && frequency <= 332) {
      return 'E4';
    } else {
      return 'Unknown';
    }
  }

  String _getTuningStatus(double frequency, String note) {
    // Simplified tuning status.
    if (note == 'A4' && frequency >= 438 && frequency <= 442) {
      return 'In Tune';
    } else if (note == 'C4' && frequency >= 261 && frequency <= 263) {
      return 'In Tune';
    } else if (note == 'E4' && frequency >= 330 && frequency <= 332) {
      return 'In Tune';
    } else {
      return 'Out of Tune';
    }
  }

  double _calculateGaugeValue(double frequency, String note) {
    // Simplified gauge calculation.
    if (note == 'A4') {
      return (frequency - 435).clamp(0, 10) / 10;
    } else if (note == 'C4') {
      return (frequency - 260).clamp(0, 4) / 4;
    } else if (note == 'E4') {
      return (frequency - 328).clamp(0, 4) / 4;
    } else {
      return 0.5;
    }
  }
}
