import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_hive/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_hive/models/note_model.dart';
import 'package:notes_hive/views/widgets/custom_app_bar.dart';
import 'package:notes_hive/views/widgets/custom_text_form_field.dart';

class EditNoteViewBody extends StatelessWidget {
  const EditNoteViewBody({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CustomAppBar(
              title: 'Edit Note',
              icon: Icons.check,
              onTap: () {
                note.save();
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 50),
            CustomTextFormField(
            onChanged: (value) {
              note.title = value;
            },
              hintText: note.title,
            ),
            const SizedBox(height: 16),
             CustomTextFormField(
              onChanged: (value) {
              note.subTitle = value;
              },
              hintText: note.subTitle,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
