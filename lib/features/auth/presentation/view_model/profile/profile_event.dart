// profile_event.dart
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileEvent extends ProfileEvent {
  final String token;

  const FetchProfileEvent(this.token);

  @override
  List<Object> get props => [token];
}
