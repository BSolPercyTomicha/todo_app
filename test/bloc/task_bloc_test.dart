import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/task/domain/entities/task.entity.dart';
import 'package:todo_app/features/task/presentation/bloc/task.bloc.dart';
import 'package:todo_app/features/task/presentation/pages/tasks.page.dart';
import 'package:todo_app/features/task/domain/usecases/get_tasks.usecase.dart';
import 'package:todo_app/features/task/domain/usecases/delete_task.usecase.dart';

class FakeDeleteTaskUseCase implements DeleteTaskUseCase {
  List<TaskEntity> tasksToReturn = [];
  Exception? errorToThrow;

  @override
  Future<void> call(int taskId) async {
    if (errorToThrow != null) throw errorToThrow!;
    Future.value(tasksToReturn);
  }
}

class FakeGetTasksUseCase implements GetTasksUseCase {
  List<TaskEntity> tasksToReturn = [];
  Exception? errorToThrow;

  @override
  Future<List<TaskEntity>> call() async {
    if (errorToThrow != null) throw errorToThrow!;
    return Future.value(tasksToReturn);
  }
}

void main() {
  group(
    'Task Bloc Tests',
    () {
      late TaskBloc bloc;
      late FakeGetTasksUseCase fakeGetTasksUseCase;
      late FakeDeleteTaskUseCase fakeDeleteTaskUseCase;

      final tTask1 = TaskEntity(
        id: 1,
        title: 'Tarea 1',
        description: 'Desc 1',
        tags: [],
        isCompleted: false,
        assignedUser: 'User 1',
      );

      final tTask2 = TaskEntity(
        id: 2,
        title: 'Tarea 2',
        description: 'Desc 2',
        tags: [],
        isCompleted: true,
        assignedUser: 'User 2',
      );

      final tTasks = [tTask1, tTask2];

      setUp(() {
        fakeGetTasksUseCase = FakeGetTasksUseCase();
        fakeDeleteTaskUseCase = FakeDeleteTaskUseCase();
        bloc = TaskBloc(
          fakeGetTasksUseCase,
          fakeDeleteTaskUseCase,
        );
      });

      tearDown(() {
        bloc.close();
      });

      test(
          'Debería emitir status.loading y luego status.success con todas las tareas cuando filter es "Todas"',
          () async {
        fakeGetTasksUseCase.tasksToReturn = tTasks;

        bloc.add(GetTasks(filter: TaskFilter.all));
        await bloc.stream
            .firstWhere((state) => state.status == TaskStatus.success);

        final emittedStates = bloc.state;
        expect(emittedStates.status, TaskStatus.success);
        expect(emittedStates.tasks.length, 2);
        expect(emittedStates.tasks, containsAll(tTasks));
      });

      test(
          'Debería emitir solo tareas completadas cuando filter es "Completadas"',
          () async {
        fakeGetTasksUseCase.tasksToReturn = tTasks;

        bloc.add(GetTasks(filter: TaskFilter.completed));
        await bloc.stream
            .firstWhere((state) => state.status == TaskStatus.success);

        final emittedStates = bloc.state;
        expect(emittedStates.status, TaskStatus.success);
        expect(emittedStates.tasks.length, 1);
        expect(emittedStates.tasks.first.isCompleted, isTrue);
      });

      test('Debería emitir error cuando el usecase lanza una Excepción',
          () async {
        fakeGetTasksUseCase.errorToThrow = Exception('Error de red');

        bloc.add(GetTasks(filter: TaskFilter.pending));

        await bloc.stream
            .firstWhere((state) => state.status == TaskStatus.error);

        final emittedStates = bloc.state;
        expect(emittedStates.status, TaskStatus.error);
        expect(emittedStates.errorMessage, 'No se pudieron cargar las tareas');
      });
    },
  );
}
