import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task.bloc.dart';
import '../pages/tasks.page.dart';

class TaskFilterChips extends StatelessWidget {
  final TaskFilter selected;
  final ValueChanged<TaskFilter> onChanged;

  const TaskFilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...TaskFilter.values.map((filter) {
          return InkWell(
            key: ValueKey('chip-$filter'),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              onChanged(filter);
              context.read<TaskBloc>().add(GetTasks(filter: filter));
            },
            child: Chip(
              label: Text(filter.label),
              backgroundColor: selected == filter
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
            ),
          );
        }).toList(),
      ],
    );
  }
}
