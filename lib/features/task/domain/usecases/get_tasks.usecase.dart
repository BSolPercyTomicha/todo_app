import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class GetTasksUseCase {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  Future<List<TaskEntity>> call() async {
    return await _taskRepository.getTasks();
  }
} 