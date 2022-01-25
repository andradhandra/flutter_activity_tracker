import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: TaskGrid(
          tasks: TaskPreset.allPresets,
        ),
      ),
    );
  }
}
