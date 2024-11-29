import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 128, 135, 171),
        title: const Text(
          'Settings',
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