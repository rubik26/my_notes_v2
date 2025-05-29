import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'data/datasources/local/notes_local_datasource.dart';
import 'data/repo_impl/note_repo_impl.dart';
import 'domain/repositories/note_repo.dart';
import 'domain/usecases/add_note.dart';
import 'domain/usecases/delete_note.dart';
import 'domain/usecases/get_notes.dart';
import 'domain/usecases/update_note.dart';
import 'presentation/bloc/note_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  await GetStorage.init();
  sl.registerLazySingleton(() => GetStorage());

  // Data sources
  sl.registerLazySingleton<NotesLocalDatasource>(
    () => NotesLocalDatasourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<NoteRepo>(
    () => NoteRepoImpl(),
  );

  // Use cases
  sl.registerLazySingleton(() => AddNote(sl<NoteRepo>()));
  sl.registerLazySingleton(() => DeleteNote(sl<NoteRepo>()));
  sl.registerLazySingleton(() => UpdateNote(sl<NoteRepo>()));
  sl.registerLazySingleton(() => GetNotes(sl<NoteRepo>()));

  // Bloc
  sl.registerFactory(() => NoteBloc(
        addNote: sl<AddNote>(),
        deleteNote: sl<DeleteNote>(),
        updateNote: sl<UpdateNote>(),
        getNotes: sl<GetNotes>(),
      ));
}
