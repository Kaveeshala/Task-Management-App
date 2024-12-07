
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'task_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colComplete = 'complete';

  DatabaseHelper._createInstance(); // Named constructor to create an instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance(); // Singleton instance
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for Android/iOS to store the database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/tasks.db';

    // Open/create the database at a given path
    var tasksDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return tasksDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colComplete INTEGER)',
    );
  }

  // Fetch Operation: Get all tasks from database
  Future<List<Map<String, dynamic>>> getTasksMapList() async {
    Database db = await database;
    var result = await db.query(taskTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a task into the database
  Future<int> insertTask(Task task) async {
    Database db = await database;
    var result = await db.insert(taskTable, task.toMap());
    return result;
  }

  // Update Operation: Update a task in the database
  Future<int> updateTask(Task task) async {
    Database db = await database;
    var result = await db.update(
      taskTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  // Delete Operation: Delete a task from the database
  Future<int> deleteTask(int id) async {
    Database db = await database;
    var result = await db.delete(
      taskTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  // Method to delete completed tasks from the database
  Future<int> deleteCompletedTasks() async {
    final db = await database; // Access the database
    return await db.delete(
      'tasks', // 'tasks' is the table name in your database
      where: 'complete = ?', // Condition to filter completed tasks
      whereArgs: [1], // '1' represents completed tasks in the database (assuming 1 = true)
    );
  }

  // Method to delete all tasks from the database
  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks'); // Assuming 'tasks' is your table name
  }


  // Get the number of tasks in the database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM $taskTable');
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }
}
