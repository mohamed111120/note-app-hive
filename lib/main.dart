import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_hive/constants.dart';
import 'package:notes_hive/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/views/notes_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_ovserver.dart';
import 'cubits/notes_cubit/notes_cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..fetchAllNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
        home: NotesView(),
      ),
    );
  }
}
