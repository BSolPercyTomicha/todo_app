import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class CreateTaskUseCase {
  final TaskRepository _taskRepository;

  CreateTaskUseCase(this._taskRepository);

  Future<void> call(TaskEntity task) async {
    await _taskRepository.createTask(task);
  }
}
