/*import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../models/user_models.dart';

class AppViewModel extends ChangeNotifier{
  List<Task> tasks = <Task>[];
  User user = User("John Snow");

  Color clrLvl1 = Colors.grey.shade50;
  Color clrLvl2 = Colors.grey.shade200;
  Color clrLvl3 = Colors.grey.shade800;
  Color clrLvl4 = Colors.grey.shade900;

  int get numTasks => tasks.length;

  int get numTaskRemaining => tasks.where((task) => task.complete).length; 

  String get username => user.username;

  void addTask(Task newtask){
    tasks.add(newtask);
    notifyListeners();
  }

  bool getTaskValue(int taskIndex){
    return tasks[taskIndex].complete;
  }

  String getTaskTitle(int taskIndex){
     return tasks[taskIndex].title;
  }

  void deleteTask(int taskIndex) {
    tasks.removeAt(taskIndex);
    notifyListeners();
  }

  void setTaskValue(int taskIndex, bool taskValue){
    tasks[taskIndex].complete = taskValue;
  }

  void updateUsername(String newUsername) {
    user.username = newUsername;
    notifyListeners();
  }

  void deleteAllTasks(){
    tasks.clear();
    notifyListeners();
  }

  void deleteCompletedTask(){
    tasks = tasks.where((task) => !task.complete).toList();
    notifyListeners();
  }

  void bottomSheildBuilder(Widget bottomSheildView, BuildContext context){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context, 
      builder: ((context){
        return bottomSheildView;
    }));
  }
}*/

import 'package:flutter/material.dart';
import '../models/database_helper.dart';
import '../models/task_model.dart';
import '../models/user_models.dart';

class AppViewModel extends ChangeNotifier {
  List<Task> tasks = <Task>[];
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  User user = User("John Snow");

  Color clrLvl1 = Colors.grey.shade50;
  Color clrLvl2 = Colors.grey.shade200;
  Color clrLvl3 = Colors.grey.shade800;
  Color clrLvl4 = Colors.grey.shade900;

  int get numTasks => tasks.length;

  int get numTaskRemaining => tasks.where((task) => task.complete).length;

  String get username => user.username;

  // Add task to the database and to the list
  Future<void> addTask(Task newtask) async {
    await _databaseHelper.insertTask(newtask); // Save task to the database
    tasks.add(newtask); // Add task to the local list
    notifyListeners();
  }

  // Fetch tasks from the database and update the list
  Future<void> loadTasks() async {
    var taskList = await _databaseHelper.getTasksMapList(); // Fetch tasks from the database
    tasks = taskList.map((taskMap) => Task.fromMapObject(taskMap)).toList(); // Map to Task objects
    notifyListeners();
  }

  bool getTaskValue(int taskIndex) {
    return tasks[taskIndex].complete;
  }

  String getTaskTitle(int taskIndex) {
    return tasks[taskIndex].title;
  }

  // Delete task from the database and local list
  Future<void> deleteTask(int taskIndex) async {
  if (tasks[taskIndex].id != null) {
    await _databaseHelper.deleteTask(tasks[taskIndex].id!); // Use '!' to assert that it's not null
    tasks.removeAt(taskIndex); // Remove task from the local list
    notifyListeners();
  } else {
    // Handle the case when task id is null (optional)
    print('Task ID is null, cannot delete.');
  }
}


  // Update task value (complete/incomplete) in the database and local list
  Future<void> setTaskValue(int taskIndex, bool taskValue) async {
    tasks[taskIndex].complete = taskValue;
    await _databaseHelper.updateTask(tasks[taskIndex]); // Update task in the database
    notifyListeners();
  }

  // Update the username and notify listeners
  void updateUsername(String newUsername) {
    user.username = newUsername;
    notifyListeners();
  }

  // Delete all tasks from the database and local list
  Future<void> deleteAllTasks() async {
    await _databaseHelper.deleteAllTasks(); // Delete all tasks from the database
    tasks.clear(); // Clear the local list
    notifyListeners();
  }

  // Delete all completed tasks from the local list
  Future<void> deleteCompletedTask() async {
    List<Task> remainingTasks = tasks.where((task) => !task.complete).toList(); // Filter out completed tasks
    await _databaseHelper.deleteCompletedTasks(); // Optionally, delete from the database if needed
    tasks = remainingTasks; // Update local list with non-completed tasks
    notifyListeners();
  }

  // Show a modal bottom sheet
  void bottomSheildBuilder(Widget bottomSheildView, BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return bottomSheildView;
      },
    );
  }
}
