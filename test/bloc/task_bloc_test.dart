import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/task/domain/entities/task.entity.dart';
import 'package:todo_app/features/task/presentation/bloc/task.bloc.dart';
import 'package:todo_app/features/task/presentation/pages/tasks.page.dart';
import 'package:todo_app/features/task/domain/usecases/get_tasks.usecase.dart';
import 'package:todo_app/features/task/domain/usecases/update_task.usecase.dart';
import 'package:todo_app/features/task/domain/usecases/create_task.usecase.dart';
import 'package:todo_app/features/task/domain/usecases/delete_task.usecase.dart';

class FakeCreateTaskUseCase implements CreateTaskUseCase {
  List<TaskEntity> tasksToReturn = [];
  Exception? errorToThrow;

  @override
  Future<void> call(TaskEntity task) async {
    if (errorToThrow != null) throw errorToThrow!;
    Future.value(tasksToReturn);
  }
}

class FakeUpdateTaskUseCase implements UpdateTaskUseCase {
  List<TaskEntity> tasksToReturn = [];
  Exception? errorToThrow;

  @override
  Future<void> call(TaskEntity task) async {
    if (errorToThrow != null) throw errorToThrow!;
    Future.value(tasksToReturn);
  }
}

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
  late TaskBloc bloc;
  late FakeCreateTaskUseCase fakeCreateTaskUseCase;
  late FakeUpdateTaskUseCase fakeUpdateTaskUseCase;
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
    fakeCreateTaskUseCase = FakeCreateTaskUseCase();
    fakeUpdateTaskUseCase = FakeUpdateTaskUseCase();
    fakeGetTasksUseCase = FakeGetTasksUseCase();
    fakeDeleteTaskUseCase = FakeDeleteTaskUseCase();
    bloc = TaskBloc(
      fakeCreateTaskUseCase,
      fakeUpdateTaskUseCase,
      fakeGetTasksUseCase,
      fakeDeleteTaskUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group(
    'GetTasks Event',
    () {
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

  group('CreateTask Event', () {
    test('Debería crear una tarea correctamente y luego cargar tareas',
        () async {
      final nuevaTarea = TaskEntity(
        id: 12345,
        title: 'Nueva tarea',
        description: 'Descripción',
        tags: ['Tag1'],
        isCompleted: false,
        assignedUser: 'User X',
      );

      fakeCreateTaskUseCase.errorToThrow = null;
      fakeGetTasksUseCase.tasksToReturn = [tTask1, tTask2, nuevaTarea];

      bloc.add(
        SendTask(
          title: nuevaTarea.title,
          description: nuevaTarea.description,
          isCompleted: false,
          tags: nuevaTarea.tags,
          assignedUser: nuevaTarea.assignedUser,
        ),
      );

      await bloc.stream
          .firstWhere((state) => state.status == TaskStatus.success);

      final state = bloc.state;
      expect(state.status, TaskStatus.success);
      expect(state.tasks.length, 2);
      expect(
        state.tasks.any((task) => task.title == 'Nueva tarea'),
        isTrue,
      );
    });

    test('Debería emitir error si falla al crear una tarea', () async {
      fakeCreateTaskUseCase.errorToThrow = Exception('Fallo al crear tarea');

      bloc.add(SendTask(
        title: 'Error',
        description: 'Desc',
        isCompleted: false,
        tags: [],
        assignedUser: 'User',
      ));

      await bloc.stream.firstWhere((state) => state.status == TaskStatus.error);

      final state = bloc.state;
      expect(state.status, TaskStatus.error);
      expect(state.errorMessage, 'No se pudo crear tarea');
    });
  });

  group('SendTask Event', () {
    test('Debería crear una tarea si id es null y luego cargar tareas',
        () async {
      final nuevaTarea = TaskEntity(
        id: 12345,
        title: 'Nueva tarea',
        description: 'Descripción',
        tags: ['Tag1'],
        isCompleted: false,
        assignedUser: 'User X',
      );

      fakeCreateTaskUseCase.errorToThrow = null;
      fakeGetTasksUseCase.tasksToReturn = [tTask1, tTask2, nuevaTarea];

      bloc.add(
        SendTask(
          id: null,
          title: nuevaTarea.title,
          description: nuevaTarea.description,
          isCompleted: false,
          tags: nuevaTarea.tags,
          assignedUser: nuevaTarea.assignedUser,
        ),
      );

      await bloc.stream
          .firstWhere((state) => state.status == TaskStatus.success);

      final state = bloc.state;
      expect(state.status, TaskStatus.success);
      expect(state.tasks.length, 2);
      expect(state.tasks.any((task) => task.title == 'Nueva tarea'), isTrue);
    });

    test('Debería actualizar una tarea si id no es null', () async {
      final tareaEditada = TaskEntity(
        id: 1,
        title: 'Tarea 1 editada',
        description: 'Descripcion editada',
        tags: ['Personal', 'Familia'],
        assignedUser: 'Usuario 1',
        isCompleted: false,
      );

      fakeUpdateTaskUseCase.errorToThrow = null;
      fakeGetTasksUseCase.tasksToReturn = [tareaEditada, tTask2];

      bloc.add(
        SendTask(
          id: tareaEditada.id,
          title: tareaEditada.title,
          description: tareaEditada.description,
          isCompleted: tareaEditada.isCompleted,
          tags: tareaEditada.tags,
          assignedUser: tareaEditada.assignedUser,
        ),
      );

      await bloc.stream
          .firstWhere((state) => state.status == TaskStatus.success);

      final state = bloc.state;
      expect(state.status, TaskStatus.success);
      expect(state.tasks.first.title, 'Tarea 1 editada');
    });

    test('Debería emitir error si falla al actualizar una tarea', () async {
      fakeUpdateTaskUseCase.errorToThrow =
          Exception('Fallo al actualizar tarea');

      bloc.add(
        SendTask(
          id: tTask1.id,
          title: tTask1.title,
          description: tTask1.description,
          isCompleted: tTask1.isCompleted,
          tags: tTask1.tags,
          assignedUser: tTask1.assignedUser,
        ),
      );

      await bloc.stream.firstWhere((state) => state.status == TaskStatus.error);

      final state = bloc.state;
      expect(state.status, TaskStatus.error);
      expect(state.errorMessage, 'No se pudo actualizar tarea');
    });
  });
}
