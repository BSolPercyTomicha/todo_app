import 'package:todo_app/features/task/domain/entities/task.entity.dart';

abstract class TaskRepository {
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(int taskId);
  Future<List<TaskEntity>> getTasks();
}
