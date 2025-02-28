import 'package:equatable/equatable.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllSongs extends SongEvent {
  final String? instrument;

  const FetchAllSongs({this.instrument});

  @override
  List<Object?> get props => [instrument];
}

class FetchSongById extends SongEvent {
  final String id; // Corrected: ID is now a String

  const FetchSongById({required this.id});

  @override
  List<Object> get props => [id];
}
