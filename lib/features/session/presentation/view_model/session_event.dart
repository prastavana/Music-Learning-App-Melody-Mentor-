abstract class SessionEvent {}

class LoadSessionsEvent extends SessionEvent {
  final String instrument;
  LoadSessionsEvent(this.instrument);
}
