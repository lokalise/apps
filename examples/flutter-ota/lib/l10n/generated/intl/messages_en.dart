// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(count) => "${Intl.plural(count, zero: 'You don\'t have completed tasks', one: 'You have just one completed task', other: 'You have ${count} completed tasks')}";

  static m1(count) => "${Intl.plural(count, zero: 'You don\'t have pending tasks', one: 'You have just one pending task', other: 'You have ${count} pending tasks')}";

  static m2(count) => "Total tasks: ${count}";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'addButton': MessageLookupByLibrary.simpleMessage('Add Item'),
    'button_addItem': MessageLookupByLibrary.simpleMessage('Add'),
    'completed_todo': m0,
    'hint_addItem': MessageLookupByLibrary.simpleMessage('Type your new todo'),
    'list_title': MessageLookupByLibrary.simpleMessage('Todo list'),
    'pending_todo': m1,
    'title': MessageLookupByLibrary.simpleMessage('ToDo App'),
    'title_addItem': MessageLookupByLibrary.simpleMessage('Add a new todo item'),
    'total_todo': m2
  };
}
