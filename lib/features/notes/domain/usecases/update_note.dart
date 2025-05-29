import '../entities/note.dart';
import '../repositories/note_repo.dart';

class UpdateNote {
  final NoteRepo repository;

  UpdateNote(this.repository);

  Future<void> call(String noteId, Note note) async {
    return await repository.updateNote(noteId, note);
  }
}
