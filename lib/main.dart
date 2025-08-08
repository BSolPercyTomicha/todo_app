import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'di.dart';
import 'app.dart';
import 'theme/presentation/bloc/theme.cubit.dart';
import 'features/task/presentation/bloc/ia.bloc.dart';
import 'features/task/presentation/bloc/task.bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<IABloc>()),
        BlocProvider(create: (_) => getIt<TaskBloc>()..add(GetTasks())),
      ],
      child: const MyTodoApp(),
    ),
  );
}
