import 'package:class_organizer/Shortcuts/_tasksClassFunctions.dart';
import 'package:flutter/material.dart';
import '../Shortcuts/_variableShortcuts.dart';

class Tasks extends StatefulWidget {

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar('Tasks'),

    body: Container(
      width: double.infinity, // Ensures the container takes up the full width
      height: double.infinity, // Ensures the container takes up the full height
      decoration: backgroundgradient(),

      child: Stack(

        children: [

          TaskList(listheight: 200,), //Task List again

          const SizedBox(height: 20,),

          Positioned(
            bottom: 20,
            right: 20,
            child: newTaskButton(context),
          )

        ],
      ),
    )

    );
  }

  //Button to create new tasks

  FloatingActionButton newTaskButton(BuildContext context) {
    return FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true, //To avoid overlapping with phones topbar
                context: context,
                isScrollControlled: true, // Allows the bottom sheet to take up more space
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return SafeArea(
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets, // Adjust for bottom system padding (keyboard)
                      child: Container(
                        decoration: backgroundgradient(),
                        child: Stack(
                          children: [
                            Positioned.fill(top: 20, child:  ManualTaskInput(),),//Manual Task input from TaskClassFunctions
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Swipe up or drag down to exit',
                                style: TextStyle(
                                  color: redcolor(),
                                  fontSize: 16,
                                  fontFamily: 'School',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          );
  }
}