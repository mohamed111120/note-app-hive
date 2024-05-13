import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
import 'note_item.dart';
import 'notes_list_view.dart';

class NotesViewBody extends StatelessWidget {
  const NotesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomAppBar(title: 'Notes',icon: Icons.search,),
            SizedBox(height: 20),
            NotesListView(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

