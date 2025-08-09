import '../../models/task.model.dart';

abstract class TaskDataSource {
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int taskId);
  Future<List<TaskModel>> getTasks();
}

class TaskTemporalDataSourceImpl implements TaskDataSource {
  List<TaskModel> tasks = <TaskModel>[
    TaskModel(
      id: 1,
      title: 'Tarea 1',
      description: 'Descripcion 1',
      tags: ['Personal'],
      isCompleted: false,
      assignedUser: 'Percy',
    ),
    TaskModel(
      id: 2,
      title: 'Tarea 2',
      description: 'Descripcion 2',
      tags: ['Familia', 'Amigos'],
      isCompleted: false,
      assignedUser: 'Percy',
    ),
    TaskModel(
      id: 3,
      title: 'Tarea 3',
      description: 'Descripcion 3',
      tags: ['Amigos', 'Personal'],
      isCompleted: true,
      assignedUser: 'Messi',
    ),
    TaskModel(
      id: 4,
      title: 'Universidad',
      description: 'Descripcion 4',
      tags: ['Tag 2', 'Tag 1'],
      isCompleted: true,
      assignedUser: 'Messi',
    ),
  ];

  @override
  Future<void> createTask(TaskModel task) async {
    tasks.add(task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    tasks = tasks.where((task) => task.id! != taskId).toList();
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    return tasks;
  }
}
