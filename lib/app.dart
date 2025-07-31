import 'package:flutter/material.dart';
import 'features/todo/pages/tasks.page.dart';
import 'features/stastics/presentation/pages/statistics.page.dart';
 
class MyTodoApp extends StatefulWidget {
  const MyTodoApp({super.key});
 
  @override
  State<MyTodoApp> createState() => _MyTodoAppState();
}
 
class _MyTodoAppState extends State<MyTodoApp> {
  int _selectedIndex = 0;
  bool _isSystemDark = false;
  ThemeMode _themeMode = ThemeMode.system;

  final List<String> _titles = ['Mis Tareas', 'Mis Estadísticas'];
 
  final List<Widget> _pages = const [
    TasksPage(),
    StatisticsPage(),
  ];
 
  IconData _getCurrentThemeIcon() {
    if (_themeMode == ThemeMode.system) {
      return _isSystemDark ? Icons.light_mode : Icons.dark_mode;
    }
    return _themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode;
  }
 
  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.system) {
        _themeMode = _isSystemDark ? ThemeMode.light : ThemeMode.dark;
      } else {
        _themeMode =
            _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _isSystemDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
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
      home: Scaffold(
        appBar: _selectedIndex == 0 ? AppBar(
          title: Text(_titles[_selectedIndex]),
          actions: [
            IconButton(
              icon: Icon(_getCurrentThemeIcon()),
              onPressed: _toggleTheme,
            ),
          ],
        ) : null,
        body: _pages[_selectedIndex],
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
  }
}