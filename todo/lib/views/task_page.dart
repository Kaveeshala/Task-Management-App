import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/views/add_task_view.dart';
import 'package:todo/views/header_view.dart';
import 'package:todo/views/task_info_view.dart';
import 'package:todo/views/task_list_view.dart';

import '../view_models/app_view_model.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {

    // Fetch tasks when the page is loaded
      Provider.of<AppViewModel>(context, listen: false).loadTasks();
      
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //hedader view
          Expanded(flex: 1, child: HeaderView()),
          //task info view
          Expanded(flex: 1, child: TaskInfoView()),
          //task list view
          Expanded(flex: 7, child: TaskListView()),
        ],),
      ),
      floatingActionButton: const AddTaskView(), //add button
    );
  }
}

