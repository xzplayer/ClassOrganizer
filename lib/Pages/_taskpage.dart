import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 128, 135, 171),
        title: const Text(
          'Tasks',
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