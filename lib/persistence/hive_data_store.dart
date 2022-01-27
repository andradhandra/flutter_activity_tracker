import 'package:flutter/foundation.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  Future<void> init() async {
    await Hive.initFlutter();
    //register adapters
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
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
}
