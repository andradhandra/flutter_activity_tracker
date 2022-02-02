import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';
import 'package:hive/hive.dart';

class TaskWithNameLoader extends ConsumerWidget {
  const TaskWithNameLoader({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //use ref.watch to call provider inside build
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskStateListenable(task: task),
      builder: (context, Box<TaskState> box, _) {
        final taskState = dataStore.taskState(box, task: task);
        return TaskWithName(
          task: task,
          isCompleted: taskState.isCompleted,
          onCompleted: (isCompleted) {
            // user ref.read to use provider inside callback
            ref
                .read(dataStoreProvider)
                .setTaskState(task: task, isCompleted: isCompleted);
          },
        );
      },
    );
  }
}
