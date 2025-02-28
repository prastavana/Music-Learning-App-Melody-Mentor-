import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final String? id;
  final String songName;
  final String selectedInstrument;
  final List<LyricSection> lyrics;
  final List<String> chordDiagrams;
  final List<String> docxFiles;

  const SongEntity({
    this.id,
    required this.songName,
    required this.selectedInstrument,
    required this.lyrics,
    required this.chordDiagrams,
    required this.docxFiles,
  });

  const SongEntity.empty()
      : id = '_empty.id',
        songName = '_empty.songName',
        selectedInstrument = '_empty.selectedInstrument',
        lyrics = const [],
        chordDiagrams = const [],
        docxFiles = const [];

  // ✅ Convert JSON to SongEntity
  factory SongEntity.fromJson(Map<String, dynamic> json) {
    return SongEntity(
      id: json['_id'], // Corrected: Using '_id' from API
      songName: json['songName'] ?? "", // Added null check
      selectedInstrument: json['selectedInstrument'] ?? "", // Added null check
      lyrics: (json['lyrics'] as List<dynamic>?) // Added null check
              ?.map((e) => LyricSection.fromJson(e))
              .toList() ??
          [],
      chordDiagrams:
          List<String>.from(json['chordDiagrams'] ?? []), // Added null check
      docxFiles: List<String>.from(json['docxFiles'] ?? []), // Added null check
    );
  }

  // ✅ Convert SongEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Corrected: Using '_id'
      'songName': songName,
      'selectedInstrument': selectedInstrument,
      'lyrics': lyrics.map((e) => e.toJson()).toList(),
      'chordDiagrams': chordDiagrams,
      'docxFiles': docxFiles,
    };
  }

  @override
  List<Object?> get props =>
      [id, songName, selectedInstrument, lyrics, chordDiagrams, docxFiles];
}

class LyricSection extends Equatable {
  final String section;
  final String? lyrics;
  final List<String> parsedDocxFile;

  const LyricSection({
    required this.section,
    required this.lyrics,
    required this.parsedDocxFile,
  });

  // ✅ Convert JSON to LyricSection
  factory LyricSection.fromJson(Map<String, dynamic> json) {
    return LyricSection(
      section: json['section'] ?? "", // Added null check
      lyrics: json['lyrics'],
      parsedDocxFile:
          List<String>.from(json['parsedDocxFile'] ?? []), // Added null check
    );
  }

  // ✅ Convert LyricSection to JSON
  Map<String, dynamic> toJson() {
    return {
      'section': section,
      'lyrics': lyrics,
      'parsedDocxFile': parsedDocxFile,
    };
  }

  @override
  List<Object?> get props => [section, lyrics, parsedDocxFile];
}
