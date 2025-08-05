import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/tasks.page.dart';
import '../../domain/entities/task.entity.dart';
import '../../domain/usecases/get_tasks.usecase.dart';

part 'task.event.dart';
part 'task.state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;

  TaskBloc(this.getTasksUseCase) : super(TaskState.initial()) {
    on<GetTasks>(_onGetTasks);
  }

  Future<void> _onGetTasks(
    GetTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    try {
      final tasks = await getTasksUseCase.call();
      final filteredTasks = _filterTasks(tasks, event.filter);
      emit(state.copyWith(
        status: TaskStatus.success,
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
}
