import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String _title;
  final Widget _body;
  final Widget? _floatingActionButton;

  const BaseScreen({
    super.key,
    required String title,
    required Widget body,
    Widget? floatingActionButton,
  })  : _title = title,
        _body = body,
        _floatingActionButton = floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: SafeArea(child: _body),
      floatingActionButton: _floatingActionButton,
    );
  }
}
