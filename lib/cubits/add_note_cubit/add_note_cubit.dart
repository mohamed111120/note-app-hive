import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_hive/constants.dart';
import 'package:notes_hive/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

    Color color =     Color(0xff5C2751);

        bool isLoading =false ;
  addNote(NoteModel note) async {
    isLoading =true ;
    emit(AddNoteLoadingState());
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      isLoading =false;
      note.color = color.value ;
      await notesBox.add(note);

      emit(AddNoteSuccessState());

    } catch (e) {
      isLoading =false;
      emit(AddNoteFailureState(e.toString()));
    }
  }
}
