import '../entities/note.dart';
import '../repositories/note_repo.dart';

class AddNote {
  final NoteRepo repository;

  AddNote(this.repository);

  Future<void> call(Note note) async {
    return await repository.addNote(note);
  }
}
