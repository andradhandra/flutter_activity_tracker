import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_flip_button.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskGridPage extends StatelessWidget {
  const TaskGridPage({
    Key? key,
    required this.tasks,
    this.onFlip,
  }) : super(key: key);
  final List<TaskModel> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.of(context).primary,
        body: TaskGridContent(
          tasks: tasks,
          onFlip: onFlip,
        ),
      ),
    );
  }
}

class TaskGridContent extends StatelessWidget {
  const TaskGridContent({Key? key, required this.tasks, this.onFlip})
      : super(key: key);
  final List<TaskModel> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 24.0,
            ),
            child: TaskGrid(
              tasks: tasks,
            ),
          ),
        ),
        HomePageFlipButton(
          onFlip: onFlip,
        )
      ],
    );
  }
}
