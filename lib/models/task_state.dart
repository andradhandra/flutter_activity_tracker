import 'package:hive/hive.dart';

part 'task_state.g.dart';

@HiveType(typeId: 1)
class TaskState {
  TaskState({
    required this.taskId,
    required this.isCompleted,
  });

  @HiveField(0)
  final String taskId;
  @HiveField(1)
  final bool isCompleted;
}
