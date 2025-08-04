import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...TaskFilter.values.map((filter) {
            return InkWell(
              key: ValueKey('chip-$filter'),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => onChanged(filter),
              child: Chip(
                label: Text(filter.label),
                backgroundColor: selected == filter ? Theme.of(context).colorScheme.primaryContainer : null,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}