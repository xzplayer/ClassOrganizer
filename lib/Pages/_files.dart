import 'package:flutter/material.dart';

class Files extends StatefulWidget {

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 128, 135, 171),
        title: const Text(
          'Files',
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