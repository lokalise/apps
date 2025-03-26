import 'package:flutter/material.dart';
import 'package:lokalise_flutter_sdk/lokalise_flutter_sdk.dart';
import 'package:to_do_app/app/models/todo_model.dart';
import 'package:to_do_app/app/views/custom_widgets/loading.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/add_todo_button.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/todo_section.dart';
import 'package:to_do_app/l10n/generated/l10n.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(Lt.of(context).list_title)),
      floatingActionButton: AddTodoButton(onAddPress: _onAddTodo),
      body: _isLoading
          ? const Loading()
          : SafeArea(
              child: _buildBody(context),
            ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final completed = widget._todos.where((e) => e.completed).toList();
    final pending = widget._todos.where((e) => !e.completed).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            Lt.of(context).total_todo(widget._todos.length),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: TodoSection(
              title: Lt.of(context).pending_todo(pending.length),
              todos: pending,
              onTodoPress: _onTodoPress,
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: TodoSection(
              title: Lt.of(context).completed_todo(completed.length),
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
