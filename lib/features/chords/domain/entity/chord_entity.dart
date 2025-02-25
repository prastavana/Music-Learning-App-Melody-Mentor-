import 'package:equatable/equatable.dart';

class ChordEntity extends Equatable {
  final String id;
  final String songName;
  final String selectedInstrument;
  final List<String> chordDiagrams;
  final List<LyricSection> lyrics;
  final List<String> docxFiles; // Added docxFiles to match backend

  const ChordEntity({
    required this.id,
    required this.songName,
    required this.selectedInstrument,
    required this.chordDiagrams,
    required this.lyrics,
    required this.docxFiles, // Added docxFiles field
  });

  @override
  List<Object?> get props =>
      [id, songName, selectedInstrument, chordDiagrams, lyrics, docxFiles];
}

class LyricSection extends Equatable {
  final String section;
  final String lyrics;
  final List<String>? parsedDocxFile;

  const LyricSection({
    required this.section,
    required this.lyrics,
    this.parsedDocxFile,
  });

  @override
  List<Object?> get props => [section, lyrics, parsedDocxFile];
}
