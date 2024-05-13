import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_hive/models/note_model.dart';

import 'note_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NoteModel> notes = BlocProvider.of<NotesCubit>(context).notes ?? [];
        return Expanded(
          child: ListView.separated(
            itemCount: notes.length ,
            itemBuilder: (context, index) {
              return NoteItem(
                  note: notes[index]  ,
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10,),
          ),
        );
      },
    );
  }
}
