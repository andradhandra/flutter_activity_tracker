import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const frontTaskBoxName = 'frontTasks';
  static const backTaskBoxName = 'backTasks';
  static const taskStateBoxName = 'tasksState';
  static String taskStateKey(String key) => 'taskState/$key';

  Future<void> init() async {
    try {
      await Hive.initFlutter();
      //register adapters
      Hive.registerAdapter<TaskModel>(TaskModelAdapter());
      Hive.registerAdapter<TaskState>(TaskStateAdapter());
      //open boxes
      await Hive.openBox<TaskModel>(frontTaskBoxName);
      await Hive.openBox<TaskModel>(backTaskBoxName);
      await Hive.openBox<TaskState>(taskStateBoxName);
    } catch (e) {
      print('Hive openbox init error');
      print(e);
    }
  }

  Future<void> createTask({
    required List<TaskModel> frontTasks,
    required List<TaskModel> backTasks,
    bool isForced = false,
  }) async {
    final frontBox = Hive.box<TaskModel>(frontTaskBoxName);
    if (frontBox.isEmpty || isForced) {
      await frontBox.clear();
      await frontBox.addAll(frontTasks);
    } else {
      print('Box already has ${frontBox.length} items');
    }
    final backBox = Hive.box<TaskModel>(frontTaskBoxName);
    if (backBox.isEmpty || isForced) {
      await backBox.clear();
      await backBox.addAll(frontTasks);
    } else {
      print('Box already has ${backBox.length} items');
    }
  }

  ValueListenable<Box<TaskModel>> frontTaskListenable() {
    return Hive.box<TaskModel>(frontTaskBoxName).listenable();
  }

  ValueListenable<Box<TaskModel>> backTaskListenable() {
    return Hive.box<TaskModel>(backTaskBoxName).listenable();
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

  TaskState taskState(Box<TaskState> box, {required TaskModel task}) {
    final key = taskStateKey(task.id);
    return box.get(key) ?? TaskState(taskId: task.id, isCompleted: false);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});
