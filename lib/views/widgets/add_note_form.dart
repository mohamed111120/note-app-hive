import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_hive/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_hive/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_hive/models/note_model.dart';

import 'colors_list_view.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 16,
          left: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 32),
              CustomTextFormField(
                onSaved: (value) {
                  title = value;
                },
                hintText: 'Title',
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  content = value;
                },
                hintText: 'Content',
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ColorsListView(),
              const SizedBox(height: 16),
              BlocBuilder<AddNoteCubit, AddNoteState>(
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state is AddNoteLoadingState ? true : false,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var currentDate = DateTime.now();
                        var formattedCurrentDate =
                            DateFormat.yMd().format(currentDate);
                        var noteModel = NoteModel(
                            title: title!,
                            subTitle: content!,
                            date: formattedCurrentDate,
                            color:  BlocProvider.of<AddNoteCubit>(context).color.value);
                        BlocProvider.of<AddNoteCubit>(context)
                            .addNote(noteModel);
                        BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}