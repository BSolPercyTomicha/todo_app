import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di.dart';
import 'app.dart';
import 'theme/presentation/bloc/theme.cubit.dart';
import 'features/task/presentation/bloc/task.bloc.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<TaskBloc>()..add(GetTasks())),
      ],
      child: const MyTodoApp(),
    ),
  );
}
