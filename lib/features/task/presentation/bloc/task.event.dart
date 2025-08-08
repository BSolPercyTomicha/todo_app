part of 'task.bloc.dart';

sealed class TaskEvent {}

class GetTasks extends TaskEvent {
  final TaskFilter filter;
  GetTasks({this.filter = TaskFilter.pending});
}

class CreateTask extends TaskEvent {
  final String title;
  final String description;
  final List<String> tags;
  final String assignedUser;
  CreateTask({
    required this.title,
    required this.description,
    required this.tags,
    required this.assignedUser,
  });
}

class DeleteTask extends TaskEvent {
  final int taskId;
  DeleteTask(this.taskId);
}
