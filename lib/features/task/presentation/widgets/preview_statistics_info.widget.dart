import 'package:flutter/material.dart';

class PreviewStatisticsInfo extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  const PreviewStatisticsInfo({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
        totalTasks == 0 ? 0 : ((completedTasks / totalTasks) * 100).floor();
    final pendingTasks = totalTasks - completedTasks;
    final hasPendingTasks = pendingTasks > 0;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(8.0),
          minHeight: 20,
          value: percentage / 100,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              )),
          child: Center(
            child: Text(
              '$percentage %',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: hasPendingTasks ? 58 : 50, right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: hasPendingTasks
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Text(
                completedTasks > 0
                    ? 'Completadas (${completedTasks == totalTasks ? '$completedTasks / $totalTasks' : completedTasks})'
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (pendingTasks > 0)
                Text(
                  'Pendientes ($pendingTasks)',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
