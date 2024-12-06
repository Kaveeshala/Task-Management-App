import 'package:flutter/material.dart';

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
}