part of 'task.bloc.dart';

sealed class TaskEvent {}

class GetTasks extends TaskEvent {
  final TaskFilter filter;
  GetTasks({this.filter = TaskFilter.pending});
}

class ChangeStatus extends TaskEvent {
  final TaskEntity taskEntity;
  ChangeStatus(this.taskEntity);
}

class SendTask extends TaskEvent {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final List<String> tags;
  final String assignedUser;

  SendTask({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.tags,
    required this.assignedUser,
  });
}

class DeleteTask extends TaskEvent {
  final int taskId;
  DeleteTask(this.taskId);
}
