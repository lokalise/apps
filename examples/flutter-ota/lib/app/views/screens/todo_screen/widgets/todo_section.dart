import 'package:flutter/material.dart';
import 'package:to_do_app/app/models/todo_model.dart';
import 'package:to_do_app/app/views/screens/todo_screen/widgets/todo_row.dart';

class TodoSection extends StatelessWidget {
  final String _title;
  final List<TodoModel> _todos;
  final Function(TodoModel model) _onTodoPress;

  const TodoSection({
    super.key,
    required String title,
    required List<TodoModel> todos,
    required Function(TodoModel model) onTodoPress,
  })  : _title = title,
        _todos = todos,
        _onTodoPress = onTodoPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        Expanded(child: _buildList()),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        _title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: _listContainerDecoration(),
      child: ListView(
        children: _todos
            .map((e) => TodoRow(todo: e, onTodoPress: _onTodoPress))
            .toList(),
      ),
    );
  }

  BoxDecoration _listContainerDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: Colors.grey.shade100, spreadRadius: 5, blurRadius: 7),
      ],
    );
  }
}
