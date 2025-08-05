part of 'task.bloc.dart';

sealed class TaskEvent {}

class GetTasks extends TaskEvent {
  final TaskFilter filter;
  GetTasks({this.filter = TaskFilter.pending});
}