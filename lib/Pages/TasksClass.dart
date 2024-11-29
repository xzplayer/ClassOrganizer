
import 'package:hive_flutter/hive_flutter.dart';

part 'TasksClass.g.dart';

//Class that represents tasks, saved in Hive
@HiveType(typeId: 0) // Unique typeId for each model
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime dueDate;

  Task({required this.title, required this.dueDate});
}

