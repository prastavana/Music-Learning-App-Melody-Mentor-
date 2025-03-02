import '../../domain/entity/note.dart';

abstract class TunerState {}

class TunerInitial extends TunerState {}

class TunerLoading extends TunerState {}

class TunerLoaded extends TunerState {
  final double? frequency;
  final Note? closestNote;

  TunerLoaded({this.frequency, this.closestNote});
}

class TunerError extends TunerState {}
