import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  static const taskStateBoxName = 'tasksState';
  static String taskStateKey(String key) => 'taskState/$key';

  Future<void> init() async {
    await Hive.initFlutter();
    //register adapters
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());
    //open boxes
    await Hive.openBox<TaskModel>(taskBoxName);
  }

  Future<void> createTask({
    required List<TaskModel> tasks,
    bool isForced = false,
  }) async {
    final box = Hive.box<TaskModel>(taskBoxName);
    if (box.isEmpty || isForced) {
      await box.clear();
      await box.addAll(tasks);
    }
  }

  ValueListenable<Box<TaskModel>> taskListenable() {
    return Hive.box<TaskModel>(taskBoxName).listenable();
  }

  Future<void> setTaskState({
    required TaskModel task,
    required bool isCompleted,
  }) async {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final taskState = TaskState(taskId: task.id, isCompleted: isCompleted);
    await box.put(taskStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenable(
      {required TaskModel task}) {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: <String>[key]);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});
