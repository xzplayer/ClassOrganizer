import 'package:flutter/material.dart';
import '../Shortcuts/_variableShortcuts.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar('Settings'),

    );
  }
}