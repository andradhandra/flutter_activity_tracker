import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskGridPage extends StatelessWidget {
  const TaskGridPage({Key? key, required this.tasks}) : super(key: key);
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).primary,
        body: TaskGridContent(tasks: tasks),
      ),
    );
  }
}

class TaskGridContent extends StatelessWidget {
  const TaskGridContent({Key? key, required this.tasks}) : super(key: key);
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return TaskGrid(
      tasks: tasks,
    );
  }
}
