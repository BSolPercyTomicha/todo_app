import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/tasks.page.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/usecases/get_tasks.usecase.dart';
import '../../domain/usecases/delete_task.usecase.dart';

part 'task.event.dart';
part 'task.state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final DeleteTaskUseCase deleteTask;

  TaskBloc(this.getTasksUseCase, this.deleteTask) : super(TaskState.initial()) {
    on<GetTasks>(_onGetTasks);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onGetTasks(
    GetTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      final tasks = await getTasksUseCase.call();
      final completedTasks =
          tasks.where((task) => task.isCompleted).toList().length;
      final filteredTasks = _filterTasks(tasks, event.filter);
      emit(state.copyWith(
        status: TaskStatus.success,
        currentFilter: event.filter,
        completedTasks: completedTasks,
        totalTasks: tasks.length,
        tasks: filteredTasks,
      ));
    } on Exception {
      emit(state.copyWith(
        status: TaskStatus.error,
        errorMessage: 'No se pudieron cargar las tareas',
      ));
    }
  }

  List<TaskEntity> _filterTasks(List<TaskEntity> tasks, TaskFilter filter) {
    if (filter == TaskFilter.all) return List.from(tasks);
    final showCompleted = filter == TaskFilter.completed;
    return tasks.where((task) => task.isCompleted == showCompleted).toList();
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      await deleteTask.call(event.taskId);
      add(GetTasks(filter: state.currentFilter));
    } on Exception {
      emit(state.copyWith(
        status: TaskStatus.error,
        errorMessage: 'No se pudo eliminar tarea',
      ));
    }
  }
}
