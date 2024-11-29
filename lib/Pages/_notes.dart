import 'package:flutter/material.dart';

class Notes extends StatefulWidget {

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 128, 135, 171),
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize:40,
            color: Color.fromARGB(255, 163, 13, 13),
            fontWeight: FontWeight.w200,
            fontFamily: 'School',

          ),
          
          ),
        centerTitle: true,

      

    ),

    );
  }
}