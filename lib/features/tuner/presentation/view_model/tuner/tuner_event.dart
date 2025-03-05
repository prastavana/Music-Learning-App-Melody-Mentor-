part of 'tuner_bloc.dart';

abstract class TunerEvent extends Equatable {
  const TunerEvent();

  @override
  List<Object> get props => [];
}

class StartRecordingEvent extends TunerEvent {}

class StopRecordingEvent extends TunerEvent {}
