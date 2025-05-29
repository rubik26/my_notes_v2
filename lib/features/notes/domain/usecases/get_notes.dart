import '../entities/note.dart';
import '../repositories/note_repo.dart';

class GetNotes {
  final NoteRepo notesRepository;

  GetNotes(this.notesRepository);

  Future<List<Note>> call() async {
    return await notesRepository.getNotes();
  }
}
