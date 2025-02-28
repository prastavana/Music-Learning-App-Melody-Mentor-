import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/song_entity.dart';

part 'song_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.songTableId)
class SongHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String songName;

  @HiveField(2)
  final String selectedInstrument;

  @HiveField(3)
  final List<LyricSectionHiveModel> lyrics;

  @HiveField(4)
  final List<String> chordDiagrams;

  @HiveField(5)
  final List<String> docxFiles;

  SongHiveModel({
    String? id,
    required this.songName,
    required this.selectedInstrument,
    required this.lyrics,
    required this.chordDiagrams,
    required this.docxFiles,
  }) : id = id ?? const Uuid().v4();

  const SongHiveModel.initial()
      : id = '',
        songName = '',
        selectedInstrument = '',
        lyrics = const [],
        chordDiagrams = const [],
        docxFiles = const [];

  // From Entity
  factory SongHiveModel.fromEntity(SongEntity entity) {
    return SongHiveModel(
      id: entity.id,
      songName: entity.songName,
      selectedInstrument: entity.selectedInstrument,
      lyrics: entity.lyrics
          .map((e) => LyricSectionHiveModel.fromEntity(e))
          .toList(),
      chordDiagrams: entity.chordDiagrams,
      docxFiles: entity.docxFiles,
    );
  }

  // To Entity
  SongEntity toEntity() {
    return SongEntity(
      id: id,
      songName: songName,
      selectedInstrument: selectedInstrument,
      lyrics: lyrics.map((e) => e.toEntity()).toList(),
      chordDiagrams: chordDiagrams,
      docxFiles: docxFiles,
    );
  }

  @override
  List<Object?> get props =>
      [id, songName, selectedInstrument, lyrics, chordDiagrams, docxFiles];
}

@HiveType(typeId: HiveTableConstant.lyricSectionTableId)
class LyricSectionHiveModel extends Equatable {
  @HiveField(0)
  final String section;

  @HiveField(1)
  final String lyrics;

  @HiveField(2)
  final List<String> parsedDocxFile;

  LyricSectionHiveModel({
    required this.section,
    required this.lyrics,
    required this.parsedDocxFile,
  });

  // From Entity
  factory LyricSectionHiveModel.fromEntity(LyricSection entity) {
    return LyricSectionHiveModel(
      section: entity.section,
      lyrics: entity.lyrics,
      parsedDocxFile: entity.parsedDocxFile,
    );
  }

  // To Entity
  LyricSection toEntity() {
    return LyricSection(
      section: section,
      lyrics: lyrics,
      parsedDocxFile: parsedDocxFile,
    );
  }

  @override
  List<Object?> get props => [section, lyrics, parsedDocxFile];
}
