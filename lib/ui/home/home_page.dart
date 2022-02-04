import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';
import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final dataStore = ref.watch(dataStoreProvider);
      return PageFlipBuilder(
        key: _pageFlipKey,
        frontBuilder: (_) => ValueListenableBuilder(
          valueListenable: dataStore.frontTaskListenable(),
          builder: (_, Box<TaskModel> box, __) => TaskGridPage(
            key: ValueKey(1),
            tasks: box.values.toList(),
            onFlip: _pageFlipKey.currentState?.flip,
          ),
        ),
        backBuilder: (_) => ValueListenableBuilder(
          valueListenable: dataStore.backTaskListenable(),
          builder: (_, Box<TaskModel> box, __) => TaskGridPage(
            key: ValueKey(2),
            tasks: box.values.toList(),
            onFlip: _pageFlipKey.currentState?.flip,
          ),
        ),
      );
    });
  }
}
