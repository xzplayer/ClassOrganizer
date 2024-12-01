import 'package:class_organizer/Shortcuts/_variableShortcuts.dart';
import 'package:flutter/material.dart';

class Files extends StatefulWidget {

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar('Files')
    );
  }
}