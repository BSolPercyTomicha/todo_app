import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ia.bloc.dart';
import '../widgets/typing_text.widget.dart';
import '../../../../shared/platform_snackbar.dart';
import '../widgets/selectable_chips_group.widget.dart';

const _tags = ['Familia', 'Amigos', 'Universidad', 'Trabajo', 'Fiestas'];
const _users = ['Percy', 'Di Maria', 'Messi', 'Alexis', 'Julián'];

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _titleController = TextEditingController();
  final List<String> _tagsSelected = [];
  String _titleTask = '';
  String _description = '';
  String _userSelected = '';
  bool _enabled = false;
  bool _showDescription = false;
  bool _isEnabledCreateTaskButton = false;

  @override
  void initState() {
    _description = '';
    super.initState();
  }

  void _validateForm() {
    setState(() {
      _isEnabledCreateTaskButton = _titleController.text.isNotEmpty &&
          _description.isNotEmpty &&
          _tagsSelected.isNotEmpty &&
          _userSelected.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: const Text('Crear Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Título :'),
              TextFormField(
                controller: _titleController,
                onChanged: (value) {
                  setState(() {
                    _enabled = value.length > 4;
                  });
                },
                onFieldSubmitted: (_) => _validateForm(),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _enabled
                    ? () {
                        _showDescription = true;
                        context.read<IABloc>().add(
                              GenerateDescription(_titleController.text),
                            );
                        _validateForm();
                      }
                    : null,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Generar descripción'),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      '🤖',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (_showDescription)
                BlocConsumer<IABloc, IAState>(
                  listener: (context, state) {
                    if (state.status == IAStatus.success) {
                      _description = state.description;
                      _titleTask = _titleController.text;
                      _validateForm();
                    }
                  },
                  builder: (context, state) {
                    if (state.status == IAStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.status == IAStatus.success) {
                      return TypingText(text: _description);
                    } else if (state.status == IAStatus.error) {
                      return Text(state.errorMessage ?? 'Error desconocido');
                    }
                    return const SizedBox.shrink();
                  },
                ),
              const SizedBox(
                height: 32,
              ),
              const Text('Etiquetas : '),
              SelectableChipsGroup(
                items: _tags,
                multiSelect: true,
                selectedItems: _tagsSelected,
                onItemTap: (tag) {
                  setState(() {
                    _tagsSelected.contains(tag)
                        ? _tagsSelected.remove(tag)
                        : _tagsSelected.add(tag);
                  });
                  _validateForm();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Asignar a :'),
              SelectableChipsGroup(
                items: _users,
                selectedItem: _userSelected,
                onItemTap: (user) {
                  setState(() {
                    _userSelected = user;
                  });
                  _validateForm();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 16.0 + bottomPadding,
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: ElevatedButton(
          onPressed: _isEnabledCreateTaskButton
              ? () {
                  if (_titleTask != _titleController.text) {
                    PlatformSnackBar.show(context,
                        message:
                            'Es posible que el título de tu tarea haya cambiado. Considera generar una nueva descripción.');
                  }
                }
              : null,
          child: const Text('Crear Tarea'),
        ),
      ),
    );
  }
}
