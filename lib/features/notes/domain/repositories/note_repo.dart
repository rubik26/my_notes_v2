import '../entities/note.dart';

abstract class NoteRepo {
  Future<void> addNote(Note note);

  Future<void> deleteNote(String noteId);

  Future<List<Note>> getNotes();

  Future<void> updateNote(String noteId, Note updatedNote);
}
