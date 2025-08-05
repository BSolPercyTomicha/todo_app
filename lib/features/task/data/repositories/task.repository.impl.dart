import '../../domain/entities/task.entity.dart';
import '../../domain/repositories/task.repository.dart';
import '../datasources/temporal/task_temporal.datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _datasource;

  TaskRepositoryImpl(this._datasource);

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await _datasource.getTasks();
  }
}
