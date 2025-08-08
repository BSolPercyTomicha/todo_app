import '../entities/task.entity.dart';
import '../repositories/task.repository.dart';

class UpdateTaskUseCase {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  Future<void> call(TaskEntity task) async {
    await _taskRepository.updateTask(task);
  }
}
