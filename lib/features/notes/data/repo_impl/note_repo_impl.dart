import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repo.dart';

class NoteRepoImpl extends NoteRepo {
  final List<Note> _notes = [];
  @override
  Future<void> addNote(Note note) async {
    _notes.add(note);
  }

  @override
  Future<void> deleteNote(String noteId) {
    return Future(() {
      _notes.removeWhere((note) => note.id == noteId);
    });
  }

  @override
  Future<List<Note>> getNotes() => Future.value(List.unmodifiable(_notes));

  @override
  Future<void> updateNote(String noteId, Note updatedNote) {
    return Future(() {
      final index = _notes.indexWhere((note) => note.id == noteId);
      if (index != -1) {
        _notes[index] =
            updatedNote.copyWith(id: noteId, updatedAt: DateTime.now());
      } else {
        throw Exception('Note not found');
      }
    });
  }
}
