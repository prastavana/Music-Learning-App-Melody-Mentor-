part of 'tuner_bloc.dart';

abstract class TunerState extends Equatable {
  const TunerState();

  @override
  List<Object> get props => [];
}

class TunerInitial extends TunerState {}

class RecordingState extends TunerState {
  final String note;
  final String status;
  final double frequency;
  final double gaugeValue;

  const RecordingState(
      {required this.note,
      required this.status,
      required this.frequency,
      required this.gaugeValue});

  @override
  List<Object> get props => [note, status, frequency, gaugeValue];
}

class NotRecordingState extends TunerState {}
