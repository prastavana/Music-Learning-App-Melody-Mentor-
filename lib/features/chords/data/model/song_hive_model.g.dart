// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongHiveModelAdapter extends TypeAdapter<SongHiveModel> {
  @override
  final int typeId = 1;

  @override
  SongHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongHiveModel(
      id: fields[0] as String?,
      songName: fields[1] as String,
      selectedInstrument: fields[2] as String,
      lyrics: (fields[3] as List).cast<LyricSectionHiveModel>(),
      chordDiagrams: (fields[4] as List).cast<String>(),
      docxFiles: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SongHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.selectedInstrument)
      ..writeByte(3)
      ..write(obj.lyrics)
      ..writeByte(4)
      ..write(obj.chordDiagrams)
      ..writeByte(5)
      ..write(obj.docxFiles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LyricSectionHiveModelAdapter extends TypeAdapter<LyricSectionHiveModel> {
  @override
  final int typeId = 2;

  @override
  LyricSectionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LyricSectionHiveModel(
      section: fields[0] as String,
      lyrics: fields[1] as String,
      parsedDocxFile: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LyricSectionHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.section)
      ..writeByte(1)
      ..write(obj.lyrics)
      ..writeByte(2)
      ..write(obj.parsedDocxFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LyricSectionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
