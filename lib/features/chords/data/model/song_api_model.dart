import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/song_entity.dart';

part 'song_api_model.g.dart';

@JsonSerializable()
class SongApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? songName;
  final String? selectedInstrument;
  final List<LyricSectionApiModel>? lyrics;
  final List<String>? chordDiagrams;
  final List<String>? docxFiles;

  const SongApiModel({
    this.id,
    this.songName,
    this.selectedInstrument,
    this.lyrics,
    this.chordDiagrams,
    this.docxFiles,
  });

  factory SongApiModel.fromJson(Map<String, dynamic> json) =>
      _$SongApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongApiModelToJson(this);

  // Convert to Entity
  SongEntity toEntity() {
    return SongEntity(
      id: id,
      songName: songName ?? "",
      selectedInstrument: selectedInstrument ?? "",
      lyrics: lyrics?.map((e) => e.toEntity()).toList() ?? [],
      chordDiagrams: chordDiagrams ?? [],
      docxFiles: docxFiles ?? [],
    );
  }

  // Create from Entity
  factory SongApiModel.fromEntity(SongEntity entity) {
    return SongApiModel(
      id: entity.id,
      songName: entity.songName,
      selectedInstrument: entity.selectedInstrument,
      lyrics:
          entity.lyrics.map((e) => LyricSectionApiModel.fromEntity(e)).toList(),
      chordDiagrams: entity.chordDiagrams,
      docxFiles: entity.docxFiles,
    );
  }

  @override
  List<Object?> get props =>
      [id, songName, selectedInstrument, lyrics, chordDiagrams, docxFiles];
}

@JsonSerializable()
class LyricSectionApiModel extends Equatable {
  final String? section;
  final String? lyrics;
  final List<String>? parsedDocxFile;

  const LyricSectionApiModel({
    this.section,
    this.lyrics,
    this.parsedDocxFile,
  });

  factory LyricSectionApiModel.fromJson(Map<String, dynamic> json) =>
      _$LyricSectionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$LyricSectionApiModelToJson(this);

  // Convert to Entity
  LyricSection toEntity() {
    return LyricSection(
      section: section ?? "",
      lyrics: lyrics ?? "",
      parsedDocxFile: parsedDocxFile ?? [],
    );
  }

  // Create from Entity
  factory LyricSectionApiModel.fromEntity(LyricSection entity) {
    return LyricSectionApiModel(
      section: entity.section,
      lyrics: entity.lyrics,
      parsedDocxFile: entity.parsedDocxFile,
    );
  }

  @override
  List<Object?> get props => [section, lyrics, parsedDocxFile];
}
