import 'package:class_organizer/Shortcuts/_variableShortcuts.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar('Notes'),

    );
  }
}