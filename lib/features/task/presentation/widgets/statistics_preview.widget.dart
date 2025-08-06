import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di.dart';
import '../bloc/task.bloc.dart';
import '../pages/tasks.page.dart';
import 'preview_statistics_info.widget.dart';

class StatisticsPreview extends StatelessWidget {
  const StatisticsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: getIt<TaskBloc>()..add(GetTasks(filter: TaskFilter.all)),
      builder: (context, state) {
        if (state.status != TaskStatus.success) {
          return const PreviewStatisticsInfo(
            completedTasks: 0,
            totalTasks: 0,
          );
        }

        return PreviewStatisticsInfo(
          completedTasks: state.tasks
              .where((element) => element.isCompleted)
              .toList()
              .length,
          totalTasks: state.tasks.length,
        );
      },
    );
  }
}
