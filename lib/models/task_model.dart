import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  TaskModel({
    required this.id,
    required this.name,
    required this.iconName,
  });
  factory TaskModel.create({
    required String name,
    required String iconName,
  }) {
    final id = Uuid().v1();
    return TaskModel(id: id, name: name, iconName: iconName);
  }
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String iconName;
}
