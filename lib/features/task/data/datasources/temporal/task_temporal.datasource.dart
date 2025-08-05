import '../../models/task.model.dart';

abstract class TaskDataSource {
  Future<List<TaskModel>> getTasks();
}

class TaskTemporalDataSourceImpl implements TaskDataSource {
  @override
  Future<List<TaskModel>> getTasks() async {
    final tasks = <TaskModel>[
      TaskModel(
        id: 1,
        title: 'Tarea 1',
        description: 'Descripcion 1',
        tags: ['Tag 1'],
        isCompleted: false,
        assignedUser: 'Usuario 1',
      ),
      TaskModel(
        id: 2,
        title: 'Tarea 2',
        description: 'Descripcion 2',
        tags: ['Tag 2', 'Tag 3'],
        isCompleted: false,
        assignedUser: 'Usuario 2',
      ),
      TaskModel(
        id: 3,
        title: 'Tarea 3',
        description: 'Descripcion 3',
        tags: ['Tag 2', 'Tag 3'],
        isCompleted: true,
        assignedUser: 'Usuario 1',
      ),
      TaskModel(
        id: 4,
        title: 'Tarea 4',
        description: 'Descripcion 4',
        tags: ['Tag 2', 'Tag 1'],
        isCompleted: true,
        assignedUser: 'Usuario 2',
      ),
    ];
    return tasks;
  }
}
