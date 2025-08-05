part of 'task.bloc.dart';

enum TaskStatus { initial, loading, success, error }

class TaskState extends Equatable {
  final List<TaskEntity> tasks;
  final TaskStatus status;
  final String? errorMessage;

  const TaskState({
    required this.tasks,
    this.status = TaskStatus.initial,
    this.errorMessage,
  });

  factory TaskState.initial() => const TaskState(
        tasks: [],
        status: TaskStatus.initial,
      );

  TaskState copyWith({
    List<TaskEntity>? tasks,
    TaskStatus? status,
    String? errorMessage,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [tasks, status, errorMessage];
}