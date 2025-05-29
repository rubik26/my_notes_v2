import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/note_bloc.dart';
import '../../page/note_details_page.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<StatefulWidget> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NoteLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is NoteLoaded) {
        return ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            final note = state.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Column(
                children: [
                  Text(note.content.length > 10
                      ? '${note.content.substring(0, 10)}...'
                      : note.content),
                  Text(note.updatedAt != null
                      ? 'Updated at: ${note.updatedAt}'
                      : 'Created at: ${note.createdAt}'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailsPage(
                      noteId: note.id,
                    ),
                  ),
                );
              },
            );
          },
        );
      } else if (state is NoteError) {
        return Center(child: Text(state.message));
      }
      return Center(child: Text('No notes available'));
    });
  }
}
