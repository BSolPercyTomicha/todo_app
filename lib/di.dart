import 'package:get_it/get_it.dart';
import 'theme/presentation/bloc/theme.cubit.dart';
import 'features/task/presentation/bloc/task.bloc.dart';
import 'features/task/domain/usecases/get_tasks.usecase.dart';
import 'features/task/domain/repositories/task.repository.dart';
import 'features/task/data/repositories/task.repository.impl.dart';
import 'features/task/data/datasources/temporal/task_temporal.datasource.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<TaskDataSource>(
      () => TaskTemporalDataSourceImpl());
  getIt
      .registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => GetTasksUseCase(getIt()));
  getIt.registerFactory(() => TaskBloc(getIt()));
  getIt.registerFactory(() => ThemeCubit());
}
