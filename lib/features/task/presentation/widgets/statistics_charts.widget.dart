import 'package:flutter/material.dart';
import 'statistic_bar.widget.dart';

class StatisticsCharts extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const StatisticsCharts({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = totalTasks - completedTasks;
    final completedPercentage =
        totalTasks == 0 ? 0 : ((completedTasks / totalTasks) * 100).floor();
    final pendingPercentage = 100 - completedPercentage;

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StatisticsBar(
            label: 'Completadas',
            value: completedTasks,
            total: totalTasks,
            percentage: completedPercentage,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          StatisticsBar(
            label: 'Pendientes',
            value: pendingTasks,
            total: totalTasks,
            percentage: pendingPercentage,
            color: Theme.of(context).colorScheme.errorContainer,
          ),
        ],
      ),
    );
  }
}
