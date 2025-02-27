// Song States
import 'package:equatable/equatable.dart';

import '../../domain/entity/song_entity.dart';

abstract class SongState extends Equatable {
  @override
  List<Object> get props => [];
}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final List<SongEntity> songs;
  SongLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class SongDetailLoaded extends SongState {
  final SongEntity song;
  SongDetailLoaded(this.song);

  @override
  List<Object> get props => [song];
}

class SongError extends SongState {
  final String message;
  SongError(this.message);

  @override
  List<Object> get props => [message];
}
