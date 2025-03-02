abstract class TunerEvent {}

class StartRecordingEvent extends TunerEvent {}

class StopRecordingEvent extends TunerEvent {}

class InstrumentChangedEvent extends TunerEvent {
  final String instrument;

  InstrumentChangedEvent(this.instrument);
}
