import '../repositories/task.repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  Future<void> call(int taskId) async {
    await _taskRepository.deleteTask(taskId);
  }
}
