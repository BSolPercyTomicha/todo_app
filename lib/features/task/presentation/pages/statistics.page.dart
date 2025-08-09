import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasks.page.dart';
import '../bloc/task.bloc.dart';
import '../widgets/statistics_charts.widget.dart';
import '../widgets/preview_statistics_info.widget.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.status == TaskStatus.initial) {
              context.read<TaskBloc>().add(GetTasks(filter: TaskFilter.all));
            }

            if (state.status != TaskStatus.success) {
              return const Column(
                children: [
                  Text('Total(0)'),
                  SizedBox(
                    height: 24,
                  ),
                  StatisticsCharts(
                    completedTasks: 0,
                    totalTasks: 0,
                  ),
                ],
              );
            }

            return Column(
              children: [
                Text(
                  'Cantidad de total de tareas : ${state.totalTasks} ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                StatisticsCharts(
                  completedTasks: state.completedTasks,
                  totalTasks: state.totalTasks,
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 48,
        ),
        BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state.status == TaskStatus.success) {
              return Column(
                children: [
                  const Text(
                    'Porcentajes de tareas completadas por usuario:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ...state.userStats
                      .map(
                        (userStats) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userStats.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                            PreviewStatisticsInfo(
                              completedTasks: userStats.completed,
                              totalTasks: userStats.total,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ],
              );
            }
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('No existen datos aún'),
            );
          },
        ),
      ],
    );
  }
}
