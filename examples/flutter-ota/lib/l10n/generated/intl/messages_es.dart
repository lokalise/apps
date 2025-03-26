// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'es';

  static m0(count) => "${Intl.plural(count, zero: 'No tienes tareas completadas', one: 'Tienes solo una tarea completada', other: 'Tienes ${count} tareas completadas')}";

  static m1(count) => "${Intl.plural(count, zero: 'No tienes tareas pendientes', one: 'Tienes una tarea pendiente', other: 'Tiene ${count} tareas pendientes')}";

  static m2(count) => "Tareas totales: ${count}";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'addButton': MessageLookupByLibrary.simpleMessage('Añadir tarea'),
    'button_addItem': MessageLookupByLibrary.simpleMessage('Añadir'),
    'completed_todo': m0,
    'hint_addItem': MessageLookupByLibrary.simpleMessage('Escriba aqui su nueva tarea'),
    'list_title': MessageLookupByLibrary.simpleMessage('Lista de tareas'),
    'pending_todo': m1,
    'title': MessageLookupByLibrary.simpleMessage('aplicación ToDo'),
    'title_addItem': MessageLookupByLibrary.simpleMessage('Añada una nueva tarea'),
    'total_todo': m2
  };
}
