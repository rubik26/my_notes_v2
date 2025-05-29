import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'features/notes/notes_injections.dart' as notes_injections;
import 'features/notes/presentation/bloc/note_bloc.dart';
import 'features/notes/presentation/page/notes_page.dart';
import 'features/theme/presentation/bloc/theme_mode_bloc.dart';
import 'features/theme/theme_injections.dart' as theme_injections;

void main() async {
  await GetStorage.init();
  await notes_injections.init();

  theme_injections.initTheme();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NoteBloc>(
          create: (context) => notes_injections.sl<NoteBloc>(),
        ),
        BlocProvider<ThemeModeBloc>(
          create: (context) => theme_injections.sl<ThemeModeBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, bool>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Notes App',
          themeMode: themeState ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const NotesPage(),
        );
      },
    );
  }
}
