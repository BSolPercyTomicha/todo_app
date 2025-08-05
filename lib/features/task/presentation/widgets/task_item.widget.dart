import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entities/task.entity.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch.adaptive(
                  trackOutlineWidth:
                      MaterialStateProperty.resolveWith((states) => 1.0),
                  value: task.isCompleted,
                  activeColor: Platform.isIOS
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Colors.white,
                  activeTrackColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  onChanged: (_) {},
                ),
              ],
            ),
            title: Text(task.title),
          ),
        ),
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ],
    );
  }
}
