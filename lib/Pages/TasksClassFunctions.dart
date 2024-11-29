import 'TasksClass.dart';  
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';


//To create a Task Manually
class ManualTaskInput extends StatefulWidget {
  @override
  _ManualTaskInputState createState() => _ManualTaskInputState();
}

class _ManualTaskInputState extends State<ManualTaskInput> {

  //This is so that the user can type 
  final TextEditingController _controller = TextEditingController(); 
  DateTime? _selectedDate;

  @override
  //Get rid of the text controller, good practice to avoid memory leaks
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to show date picker and set the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked; // Store the selected date
      });
    }
  }

  void NewTask() async {
    final inputText = _controller.text;
    if (inputText.isNotEmpty && _selectedDate != null) {
        final box=Hive.box<Task>('tasks');

      final newTask = Task(
        title: inputText,
        dueDate: _selectedDate!,  // Use the selected due date
      );

      await box.add(newTask);  // Add the task to the box
      print('Task added: $inputText with due date: $_selectedDate');
    } else {
      print('No input or due date provided.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Enter a new Task:',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
         ElevatedButton(
          onPressed: () => _selectDate(context), // Trigger date picker
          child: Text(_selectedDate == null
              ? 'Select Due Date'
              : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0]), // Display selected date
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: NewTask,
          child: Text('Create Task'),
        ),
      ],
    );
  }
}


//Reable function fo the child select date

/*String getDueDateText(DateTime? selectedDate) {
  if (selectedDate == null) {
    return 'Select Due Date'; // Default text when no date is selected
  } else {
    // Format the selected date (only display YYYY-MM-DD)
    return 'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0];
  }
}*/


//Show The Tasks




/*class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>{
  
  get taskbox => Hive.box<Task>('tasks');

  // Format the due date to show 'Today' or 'Tomorrow'
  String formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    

    if (dueDate.isAtSameMomentAs(today)) {
      return "Today";
    } else if (dueDate.isAtSameMomentAs(tomorrow)) {
      return "Tomorrow";
    }else if (dueDate.isBefore(today)){
      return "Due";
    } else {
      return "${dueDate.toLocal()}".split(' ')[0]; // Standard date format (yyyy-mm-dd)
    }
  }

  // Delete task with confirmation
  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              taskbox.deleteAt(index); // Delete the task
              Navigator.of(context).pop(); // Close the dialog
              setState(() {}); // Refresh the task list
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }



  Widget build(BuildContext context) {
      
    
    return 
    ValueListenableBuilder(
      //The Value that will be listened to and updated every time
      valueListenable: Hive.box<Task>('tasks').listenable(),
       
      // A builder widget, a Value listenable builder in specific helps update constantly a specific value in a widget
      builder: (context, Box<Task> box, _) {  
        if (box.isEmpty) {
          return const Center(
            child: Text(
              "No tasks available!",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        // Sort tasks by due date
        final tasks = box.values.toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));


        //returns a scrolable view 
        return 
        
        ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final dueDateString = formatDueDate(task.dueDate);

            return Card(
              color: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  task.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Due: $dueDateString",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => _deleteTask(index), // Trigger delete
                ),
              ),
            );
          },
        );
      },
    );
  }
  }
*/

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Box<Task>? taskbox;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    taskbox = Hive.box<Task>('tasks');
    _loadTasks(); // Load tasks on initialization
  }

  void _loadTasks() {
    if (taskbox != null) {
      setState(() {
        tasks = taskbox!.values.toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      });
    }
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (taskbox != null) {
                taskbox!.deleteAt(index); // Delete the task
                Navigator.of(context).pop(); // Close the dialog
                _loadTasks(); // Refresh the task list
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  String formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));

    if (dueDate.isAtSameMomentAs(today)) {
      return "Today";
    } else if (dueDate.isAtSameMomentAs(tomorrow)) {
      return "Tomorrow";
    } else if (dueDate.isBefore(today)) {
      return "Due";
    } else {
      return "${dueDate.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          "No tasks available!",
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final dueDateString = formatDueDate(task.dueDate);

        return Card(
          color: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              task.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Due: $dueDateString",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => _deleteTask(index),
            ),
          ),
        );
      },
    );
  }
}