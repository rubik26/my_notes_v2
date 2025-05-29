import 'package:get_storage/get_storage.dart';
import '../../../domain/entities/note.dart';

abstract class NotesLocalDatasource {
  void saveNotes(List<Note> notes);
  List<Note> getNotes();
}

class NotesLocalDatasourceImpl implements NotesLocalDatasource {
  final box = GetStorage();

  @override
  void saveNotes(List<Note> notes) {
    final noteMaps = notes
        .map(
          (note) => note.toJson(),
        )
        .toList();
    box.write('notes', noteMaps);
  }

  @override
  List<Note> getNotes() {
    final data = box.read<List>('notes') ?? [];
    return data
        .map(
          (json) => Note.fromJson(
            Map<String, dynamic>.from(json),
          ),
        )
        .toList();
  }
}
