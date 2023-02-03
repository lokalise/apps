import 'package:flutter/material.dart';
import 'package:to_do_app/app/models/todo_model.dart';

class TodoRow extends StatelessWidget {
  final TodoModel _todo;
  final Function(TodoModel model) _onTodoPress;

  const TodoRow({
    super.key,
    required TodoModel todo,
    required Function(TodoModel model) onTodoPress,
  })  : _todo = todo,
        _onTodoPress = onTodoPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _todo.title,
        style: _getTextStyle(_todo.completed),
      ),
      leading: CircleAvatar(child: Text(_todo.title[0])),
      onTap: () => _onTodoPress(_todo),
    );
  }

  TextStyle? _getTextStyle(bool checked) => !checked
      ? null
      : const TextStyle(
          color: Colors.black54,
          decoration: TextDecoration.lineThrough,
        );
}
