import 'package:flutter/material.dart';
import 'package:lokalise_flutter_sdk/ota/lokalise_sdk.dart';
import 'package:to_do_app/app/models/todo_model.dart';
import 'package:to_do_app/app/views/base/base_screen.dart';
import 'package:to_do_app/app/views/custom_widgets/loading.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/add_todo_button.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/todo_section.dart';
import 'package:to_do_app/generated/l10n.dart';

class TodoScreen extends StatefulWidget {
  final List<TodoModel> _todos = [];

  TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreen();
}

class _TodoScreen extends State<TodoScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Lokalise.instance.update().then(
          (response) => setState(() => _isLoading = false),
          onError: (error) => setState(() => _isLoading = false),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Lt.of(context).list_title,
      floatingActionButton: AddTodoButton(onAddPress: _onAddTodo),
      body: _isLoading ? const Loading() : _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final completed = widget._todos.where((e) => e.completed).toList();
    final notCompleted = widget._todos.where((e) => !e.completed).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Total de tareas: 5',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: TodoSection(
              title: 'No hay tareas pendientes:',
              todos: notCompleted,
              onTodoPress: _onTodoPress,
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: TodoSection(
              title: 'No hay tareas completadas',
              todos: completed,
              onTodoPress: _onTodoPress,
            ),
          ),
        ],
      ),
    );
  }

  void _onAddTodo(TodoModel todo) => setState(() => widget._todos.add(todo));

  void _onTodoPress(TodoModel todo) =>
      setState(() => todo.completed = !todo.completed);
}
