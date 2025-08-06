part of 'task.bloc.dart';

sealed class TaskEvent {}

class GetTasks extends TaskEvent {
  final TaskFilter filter;
  GetTasks({this.filter = TaskFilter.pending});
}

class DeleteTask extends TaskEvent {
  final int taskId;
  DeleteTask(this.taskId);
}
