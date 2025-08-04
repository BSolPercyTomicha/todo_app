import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/presentation/bloc/theme.cubit.dart';
import 'features/task/presentation/pages/tasks.page.dart';
import 'features/task/presentation/pages/statistics.page.dart';
import 'features/task/presentation/pages/task_create.page.dart';

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});

  @override
  State<MyTodoApp> createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  int _selectedIndex = 0;
  final List<String> _titles = ['Mis Tareas', 'Mis Estadísticas'];
  final List<Widget> _pages = const [
    TasksPage(),
    StatisticsPage(),
  ];

  IconData _getCurrentThemeIcon(ThemeMode themeMode, bool isSystemDark) {
    if (themeMode == ThemeMode.system) {
      return isSystemDark ? Icons.light_mode : Icons.dark_mode;
    }
    return themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    final isSystemDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.grey,
                brightness: Brightness.light,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.grey,
                brightness: Brightness.dark,
              ),
            ),
            routes: {
              '/task/create': (context) => const TaskCreatePage(),
            },
            home: Scaffold(
              appBar: _selectedIndex == 0
                  ? AppBar(
                      title: Text(_titles[_selectedIndex]),
                      actions: [
                        IconButton(
                          icon: Icon(_getCurrentThemeIcon(themeMode, isSystemDark)),
                          onPressed: () {
                            context.read<ThemeCubit>().toggleTheme(isSystemDark);
                          },
                        ),
                      ],
                    )
                  : null,
              body: _pages[_selectedIndex],
              floatingActionButton: Builder(
                builder: (context) {
                  return FloatingActionButton.extended(
                    icon: const Icon(Icons.add),
                    label: const Text('Nueva Tarea'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/task/create');
                    },
                    tooltip: 'Crear nueva tarea',
                  );
                }
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.view_list_rounded), label: 'Tareas'),
                  NavigationDestination(
                      icon: Icon(Icons.bar_chart_rounded), label: 'Estadísticas'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}