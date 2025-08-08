import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasks.page.dart';
import '../bloc/task.bloc.dart';
import '../widgets/statistics_charts.widget.dart';

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
      ],
    );
  }
}
