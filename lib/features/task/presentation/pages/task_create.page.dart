import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Tarea')),
      body: const Center(child: Text('Formulario para crear de tareas')),
    );
  }
}