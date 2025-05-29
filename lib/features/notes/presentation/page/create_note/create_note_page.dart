import 'package:flutter/material.dart';
import '../../widget/notes/create_note/create_note.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
      ),
      body: const CreateNote(),
    );
  }
}
