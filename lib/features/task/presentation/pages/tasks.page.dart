import 'package:flutter/material.dart';
import '../widgets/task_filter_chips.widget.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TaskFilterChips(
          selected: _filter,
          onChanged: _onFilterChanged,
        ),
        Center(child: Text('Mis Tareas (${_filter.label})')),
      ],
    );
  }
}