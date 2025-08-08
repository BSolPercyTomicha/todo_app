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

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      tags: entity.tags,
      isCompleted: entity.isCompleted,
      assignedUser: entity.assignedUser,
    );
  }
}
