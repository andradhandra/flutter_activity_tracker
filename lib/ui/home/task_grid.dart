import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name_loader.dart';

class TaskGrid extends StatelessWidget {
  const TaskGrid({
    Key? key,
    this.tasks = const [],
  }) : super(key: key);
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) => TaskWithNameLoader(task: tasks[index]),
      itemCount: tasks.length,
    );
  }
}
