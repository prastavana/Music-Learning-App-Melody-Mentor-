// lib/features/tuner/presentation/view_model/tuner_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/analyze_frequency_usecase.dart';
import '../../domain/use_case/get_closest_note_usecase.dart';
import '../../domain/use_case/start_recording_usecase.dart';
import '../../domain/use_case/stop_recording_usecase.dart';
import 'tuner_event.dart';
import 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  final StartRecordingUseCase startRecordingUseCase;
  final StopRecordingUseCase stopRecordingUseCase;
  final AnalyzeFrequencyUseCase analyzeFrequencyUseCase;
  final GetClosestNoteUseCase getClosestNoteUseCase;
  String currentInstrument = "guitar";

  TunerBloc({
    required this.startRecordingUseCase,
    required this.stopRecordingUseCase,
    required this.analyzeFrequencyUseCase,
    required this.getClosestNoteUseCase,
  }) : super(TunerInitial()) {
    on<StartRecordingEvent>(_onStartRecording);
    on<StopRecordingEvent>(_onStopRecording);
    on<InstrumentChangedEvent>(_onInstrumentChanged);
  }

  Future<void> _onStartRecording(
      StartRecordingEvent event, Emitter<TunerState> emit) async {
    emit(TunerLoading());
    try {
      await startRecordingUseCase();
    } catch (e) {
      emit(TunerError());
    }
  }

  Future<void> _onStopRecording(
      StopRecordingEvent event, Emitter<TunerState> emit) async {
    emit(TunerLoading());
    try {
      final frequency = await analyzeFrequencyUseCase();
      if (frequency != null) {
        final note = getClosestNoteUseCase(frequency, currentInstrument);
        emit(TunerLoaded(frequency: frequency, closestNote: note));
      } else {
        emit(TunerError());
      }
    } catch (e) {
      emit(TunerError());
    }
  }

  void _onInstrumentChanged(
      InstrumentChangedEvent event, Emitter<TunerState> emit) {
    currentInstrument = event.instrument;
  }
}
