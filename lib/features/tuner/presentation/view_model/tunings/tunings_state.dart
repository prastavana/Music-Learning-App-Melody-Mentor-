part of 'tunings_cubit.dart';

abstract class TuningsState extends Equatable {
  const TuningsState();

  @override
  List<Object> get props => [];
}

class TuningsInitial extends TuningsState {}

class TuningsLoadingState extends TuningsState {}

class TuningsLoadedState extends TuningsState {
  final TuningsModel data;

  const TuningsLoadedState({required this.data});

  @override
  List<Object> get props => [data];
}

class TuningsErrorState extends TuningsState {}

class TuningsModel {
  final List<Instrument> data;

  TuningsModel({required this.data});

  factory TuningsModel.fromJson(Map<String, dynamic> json) {
    return TuningsModel(
      data: (json['data'] as List).map((e) => Instrument.fromJson(e)).toList(),
    );
  }
}

class Instrument {
  final String instrument;
  final List<Tuning> tunings;

  Instrument({required this.instrument, required this.tunings});

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      instrument: json['instrument'],
      tunings:
          (json['tunings'] as List).map((e) => Tuning.fromJson(e)).toList(),
    );
  }
}

class Tuning {
  final String name;
  final List<String> notes;

  Tuning({required this.name, required this.notes});

  factory Tuning.fromJson(Map<String, dynamic> json) {
    return Tuning(
      name: json['name'],
      notes: List<String>.from(json['notes']),
    );
  }
}
