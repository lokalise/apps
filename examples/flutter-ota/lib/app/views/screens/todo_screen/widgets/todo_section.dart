import 'package:flutter/material.dart';
import 'package:to_do_app/app/models/todo_model.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/todo_row.dart';

class TodoSection extends StatelessWidget {
  final List<TodoModel> _todos;
  final Function(TodoModel model) _onTodoPress;

  const TodoSection({
    super.key,
    required List<TodoModel> todos,
    required Function(TodoModel model) onTodoPress,
  })  : _todos = todos,
        _onTodoPress = onTodoPress;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _todos
          .map((e) => TodoRow(todo: e, onTodoPress: _onTodoPress))
          .toList(),
    );
  }
}
