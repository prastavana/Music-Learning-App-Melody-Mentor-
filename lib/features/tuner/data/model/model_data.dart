import '../../domain/entity/note.dart';

class NoteModel extends Note {
  NoteModel({required double frequency, required String name})
      : super(frequency: frequency, name: name);

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(frequency: note.frequency, name: note.name);
  }

  Note toEntity() {
    return Note(frequency: frequency, name: name);
  }
}
