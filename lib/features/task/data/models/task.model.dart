import '../../domain/entities/task.entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.tags,
    required super.isCompleted,
    required super.assignedUser,
  });
}
