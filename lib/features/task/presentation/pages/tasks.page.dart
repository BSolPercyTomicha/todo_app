import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di.dart';
import '../bloc/task.bloc.dart';
import '../widgets/task_item.widget.dart';
import '../widgets/task_filter_chips.widget.dart';
import '../widgets/preview_statistics_info.widget.dart';

enum TaskFilter {
  pending('Pendientes'),
  all('Todas'),
  completed('Completadas');

  const TaskFilter(this.label);
  final String label;
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TaskFilter _filter = TaskFilter.pending;

  void _onFilterChanged(TaskFilter filter) {
    setState(() {
      _filter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (_) =>
          getIt<TaskBloc>()..add(GetTasks(filter: TaskFilter.pending)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          TaskFilterChips(
            selected: _filter,
            onChanged: _onFilterChanged,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state.status != TaskStatus.success) {
                return const PreviewStatisticsInfo(
                  completedTasks: 0,
                  totalTasks: 0,
                );
              }

              return PreviewStatisticsInfo(
                completedTasks: state.completedTasks,
                totalTasks: state.totalTasks,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state.status == TaskStatus.success) {
                if (state.tasks.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 48.0,
                      ),
                      Center(
                        child: Text(
                          'No hay Tareas ${_filter != TaskFilter.all ? _filter.label : ''}',
                        ),
                      ),
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: state.tasks
                        .map((task) => TaskItem(task: task))
                        .toList(),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.only(top: 36.0),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          )
        ],
      ),
    );
  }
}
