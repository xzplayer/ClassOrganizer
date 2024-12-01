import '../Hive_Functions_Files/tasks_class.dart';  
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

  late final Box<Task> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }

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

      final newTask = Task(
        title: inputText,
        dueDate: _selectedDate!,  // Use the selected due date
      );

      await taskBox.add(newTask);  // Add the task to the box
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
            labelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'School',
          ),
            border: OutlineInputBorder(),
          ),
          
        ),
        const SizedBox(height: 16),

         ElevatedButton(
          onPressed: () => _selectDate(context), // Trigger date picker
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(125, 158, 158, 158),
          ),
          child:  Text(_selectedDate == null
                ? 'Select Due Date'
                : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'School',
                ),
              ),
                 // Display selected date
        ),
        const SizedBox(height: 16),
        
        ElevatedButton(
          onPressed: NewTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(125, 158, 158, 158),
          ),
            child: const Text(
              'Create Task',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'School',
                ),
            )

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




class TaskList extends StatefulWidget {

  final double listheight;
  @override

  TaskList({required this.listheight});
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList>{

  late final Box<Task> taskbox;

  @override
  void initState(){
    super.initState();
    taskbox = Hive.box<Task>('tasks');
  }



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
      return "Late Due";
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

 @override

  Widget build(BuildContext context) {
      
    
    return 
    ValueListenableBuilder(
      //The Value that will be listened to and updated every time
      valueListenable: taskbox.listenable(),
       
      // A builder widget, a Value listenable builder in specific helps update constantly a specific value in a widget
      builder: (context, Box<Task> box, _) {  
        if (box.isEmpty) {
          return 
           Container(

            color: const Color.fromARGB(24, 0, 0, 0),
            child: const Center(
              child: Text(
                "No tasks available!",
                style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
              ),
            ),
          );
        }

        // Sort tasks by due date
        final tasks = box.values.toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        
       //returns a scrolable view 
        return 
        
        Container(
          height:widget.listheight,
          child: ListView.builder(
            itemCount: tasks.length,  //Pasas the maximum number of visible items from the List
            itemBuilder: (context, index) {
              final task = tasks[index];
              final dueDateString = formatDueDate(task.dueDate);
              
              return Card( //Creates a Card Object to show the Tasks
                color: const Color.fromARGB(48, 0, 0, 0),
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Due: $dueDateString",
                    style: const TextStyle(fontSize: 16, color:  Color.fromARGB(255, 0, 0, 0)),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => _deleteTask(index), // Trigger delete
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  }

