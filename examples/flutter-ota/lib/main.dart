import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lokalise_flutter_sdk/ota/lokalise_sdk.dart';
import 'generated/l10n.dart';

class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Lokalise.instance.update().then(
        (response) => setState(() {
              _isLoading = false;
            }),
        onError: (error) => setState(() {
              _isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lt.of(context).list_title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: _isLoading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () => _displayDialog(),
              tooltip: Lt.of(context).addButton,
              child: const Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Lt.of(context).title_addItem),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: Lt.of(context).hint_addItem),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Lt.of(context).button_addItem),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      onGenerateTitle: (context) => Lt.of(context).title,
      localizationsDelegates: const [
        Lt.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Lt.supportedLocales,
      home: const TodoList(),
    );
  }
}

// void main() {
//   Lokalise.init('d24a6c4e93076b29e71347e8c39713f87f1e',
//       '595412416388cd7cdebfe5.92023764');
//   //Lokalise.setVersion(1);
//   runApp(
//     const TodoApp(),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Lokalise.init(
      sdkToken: 'd24a6c4e93076b29e71347e8c39713f87f1e',
      projectId: '595412416388cd7cdebfe5.92023764',
      preRelease: false,
      appVersion: 0);
  runApp(const TodoApp());
}
