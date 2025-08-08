import 'package:get_it/get_it.dart';
import 'ai/clients/ia_client.dart';
import 'ai/clients/azure_open_ai_client.dart';
import 'theme/presentation/bloc/theme.cubit.dart';
import 'features/task/presentation/bloc/ia.bloc.dart';
import 'features/task/presentation/bloc/task.bloc.dart';
import 'features/task/domain/repositories/ia.repository.dart';
import 'features/task/domain/usecases/get_tasks.usecase.dart';
import 'features/task/domain/usecases/delete_task.usecase.dart';
import 'features/task/domain/repositories/task.repository.dart';
import 'features/task/data/repositories/ia_repository.impl.dart';
import 'features/task/data/repositories/task.repository.impl.dart';
import 'features/task/data/datasources/remote/ia_remote.datasource.dart';
import 'features/task/domain/usecases/generate_description.usecase.dart';
import 'features/task/data/datasources/temporal/task_temporal.datasource.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<TaskDataSource>(
      () => TaskTemporalDataSourceImpl());
  getIt
      .registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => GetTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTaskUseCase(getIt()));
  getIt.registerFactory(() => TaskBloc(getIt(), getIt()));
  getIt.registerFactory(() => ThemeCubit());

  getIt.registerLazySingleton<IAssistantClient>(() => AzureOpenAIClient());
  getIt.registerLazySingleton<IADataSource>(
      () => IARemoteDataSource(getIt<IAssistantClient>()));
  getIt.registerLazySingleton<IARepository>(
      () => IARepositoryImpl(getIt<IADataSource>()));
  getIt.registerLazySingleton(
      () => GenerateDescriptionUseCase(getIt<IARepository>()));
  getIt.registerFactory(() => IABloc(getIt<GenerateDescriptionUseCase>()));
}
