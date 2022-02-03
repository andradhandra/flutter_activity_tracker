import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';
import 'package:hive/hive.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pageFlipKey = GlobalKey<PageFlipBuilderState>();
    final dataStore = ref.watch(dataStoreProvider);
    return PageFlipBuilder(
      frontPageBuilder: (_) => ValueListenableBuilder(
        valueListenable: dataStore.frontTaskListenable(),
        builder: (_, Box<TaskModel> box, __) => TaskGridPage(
          tasks: box.values.toList(),
          onFlip: () => _pageFlipKey.currentState?.flip(),
        ),
      ),
      backPageBuilder: (_) => ValueListenableBuilder(
        valueListenable: dataStore.backTaskListenable(),
        builder: (_, Box<TaskModel> box, __) => TaskGridPage(
          tasks: box.values.toList(),
          onFlip: () => _pageFlipKey.currentState?.flip(),
        ),
      ),
    );
  }
}
