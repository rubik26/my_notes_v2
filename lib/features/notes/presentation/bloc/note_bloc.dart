import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/local/notes_local_datasource.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_notes.dart';
import '../../domain/usecases/update_note.dart';

sealed class NoteEvent {}

class FetchNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final Note note;
  AddNoteEvent(this.note);
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  DeleteNoteEvent(this.id);
}

class UpdateNoteEvent extends NoteEvent {
  final String id;
  final Note note;
  UpdateNoteEvent(this.id, this.note);
}

sealed class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  NoteLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final AddNote addNote;
  final DeleteNote deleteNote;
  final GetNotes getNotes;
  final UpdateNote updateNote;

  NoteBloc({
    required this.addNote,
    required this.deleteNote,
    required this.getNotes,
    required this.updateNote,
  }) : super(
          NotesLocalDatasourceImpl().getNotes().isEmpty
              ? NoteInitial()
              : NoteLoaded(
                  NotesLocalDatasourceImpl().getNotes(),
                ),
        ) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNoteEvent>(_onAddNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<UpdateNoteEvent>(_onUpdateNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await getNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError('Failed to fetch notes'));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    await addNote(event.note);
    final notes = await getNotes();
    NotesLocalDatasourceImpl().saveNotes(notes);
    emit(NoteLoaded(notes));
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    await deleteNote(event.id);
    final notes = await getNotes();
    NotesLocalDatasourceImpl().saveNotes(notes);
    emit(NoteLoaded(notes));
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    await updateNote(event.id, event.note);
    final notes = await getNotes();
    NotesLocalDatasourceImpl().saveNotes(notes);
    emit(NoteLoaded(notes));
  }
}
