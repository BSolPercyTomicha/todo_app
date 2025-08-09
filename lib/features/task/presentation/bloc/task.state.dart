part of 'task.bloc.dart';

enum TaskStatus { initial, loading, success, error }

class TaskState extends Equatable {
  final List<TaskEntity> tasks;
  final TaskStatus status;
  final TaskFilter currentFilter;
  final int completedTasks;
  final int totalTasks;
  final String? errorMessage;
  final List<UserTaskStatsEntity> userStats;

  const TaskState({
    required this.tasks,
    required this.currentFilter,
    required this.completedTasks,
    required this.totalTasks,
    required this.userStats,
    this.status = TaskStatus.initial,
    this.errorMessage,
  });

  factory TaskState.initial() => const TaskState(
        tasks: [],
        currentFilter: TaskFilter.pending,
        completedTasks: 0,
        totalTasks: 0,
        status: TaskStatus.initial,
        userStats: [],
      );

  TaskState copyWith({
    List<TaskEntity>? tasks,
    TaskFilter? currentFilter,
    int? completedTasks,
    int? totalTasks,
    TaskStatus? status,
    String? errorMessage,
    List<UserTaskStatsEntity>? userStats,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      currentFilter: currentFilter ?? this.currentFilter,
      completedTasks: completedTasks ?? this.completedTasks,
      totalTasks: totalTasks ?? this.totalTasks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      userStats: userStats ?? this.userStats,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        currentFilter,
        completedTasks,
        totalTasks,
        status,
        errorMessage,
        userStats,
      ];
}
