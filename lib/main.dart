import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Pages/_home.dart';
import 'Pages/_files.dart';
import 'Pages/_notes.dart';
import 'Pages/_settings.dart';
import 'Pages/_taskpage.dart';
import 'pages/TasksClass.dart';  


void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  // Step 1: Initialize Hive
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(TaskAdapter()); // Register the Task model
  await Hive.openBox<Task>('tasks'); // Open a Hive box for tasks
  // Step 2: Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Step 3: MaterialApp setup with routes
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Files': (context) => Files(),
        '/Notes': (context) => Notes(),
        '/Settings': (context) => Settings(),
        '/Tasks': (context) => Tasks(),
      },
    );
  }
}