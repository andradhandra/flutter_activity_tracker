import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/ui/task/animated_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskWithName extends StatelessWidget {
  const TaskWithName({
    Key? key,
    required this.task,
    this.isCompleted = false,
    this.onCompleted,
  }) : super(key: key);

  final TaskModel task;
  final bool isCompleted;
  final ValueChanged<bool>? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTask(
            iconName: task.iconName,
            isCompleted: isCompleted,
            onCompleted: onCompleted,
          ),
          SizedBox(height: 12),
          Flexible(
            child: Text(
              task.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyles.taskName.copyWith(
                color: AppTheme.of(context).accent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
