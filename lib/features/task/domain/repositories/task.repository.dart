import 'package:todo_app/features/task/domain/entities/task.entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks();
}
