import '../models/task.model.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/repositories/task.repository.dart';
import '../datasources/temporal/task_temporal.datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _datasource;

  TaskRepositoryImpl(this._datasource);
  @override
  Future<void> createTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    return await _datasource.createTask(taskModel);
  }

  @override
  Future<void> deleteTask(int taskId) async {
    return await _datasource.deleteTask(taskId);
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await _datasource.getTasks();
  }
}
