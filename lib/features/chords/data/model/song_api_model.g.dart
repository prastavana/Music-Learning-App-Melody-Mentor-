// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongApiModel _$SongApiModelFromJson(Map<String, dynamic> json) => SongApiModel(
      id: json['_id'] as String?,
      songName: json['songName'] as String?,
      selectedInstrument: json['selectedInstrument'] as String?,
      lyrics: (json['lyrics'] as List<dynamic>?)
          ?.map((e) => LyricSectionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      chordDiagrams: (json['chordDiagrams'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      docxFiles: (json['docxFiles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SongApiModelToJson(SongApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'songName': instance.songName,
      'selectedInstrument': instance.selectedInstrument,
      'lyrics': instance.lyrics,
      'chordDiagrams': instance.chordDiagrams,
      'docxFiles': instance.docxFiles,
    };

LyricSectionApiModel _$LyricSectionApiModelFromJson(
        Map<String, dynamic> json) =>
    LyricSectionApiModel(
      section: json['section'] as String?,
      lyrics: json['lyrics'] as String?,
      parsedDocxFile: (json['parsedDocxFile'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LyricSectionApiModelToJson(
        LyricSectionApiModel instance) =>
    <String, dynamic>{
      'section': instance.section,
      'lyrics': instance.lyrics,
      'parsedDocxFile': instance.parsedDocxFile,
    };
