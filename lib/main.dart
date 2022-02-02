import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/models/task_model.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataStore = HiveDataStore();
  await AppAssets.preloadSVGs();
  await dataStore.init();
  await dataStore.createTask(
    tasks: [
      TaskModel.create(name: 'Main bola', iconName: AppAssets.basketball),
      TaskModel.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
      TaskModel.create(name: 'Walk the Dog', iconName: AppAssets.dog),
      TaskModel.create(name: 'Do Some Coding', iconName: AppAssets.html),
      TaskModel.create(name: 'Meditate', iconName: AppAssets.meditation),
      TaskModel.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
    ],
  );
  runApp(ProviderScope(
    overrides: [
      dataStoreProvider.overrideWithValue(dataStore),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
