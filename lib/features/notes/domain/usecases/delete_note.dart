import '../repositories/note_repo.dart';

class DeleteNote {
  final NoteRepo repository;

  DeleteNote(this.repository);

  Future<void> call(String noteId) async {
    return await repository.deleteNote(noteId);
  }
}
