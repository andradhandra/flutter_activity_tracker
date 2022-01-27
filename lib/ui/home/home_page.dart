import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';
import 'package:hive/hive.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<TaskModel>(HiveDataStore.taskBoxName);
    final dataStore = HiveDataStore();
    return ValueListenableBuilder(
      valueListenable: dataStore.taskListenable(),
      builder: (_, Box<TaskModel> box, __) => TaskGridPage(
        tasks: box.values.toList(),
      ),
    );
  }
}
