// GENERATED CODE
//
// After the template files .arb have been changed,
// generate this class by the command in the terminal:
// flutter pub run lokalise_flutter_sdk:gen-lok-l10n
//
// Please see https://pub.dev/packages/lokalise_flutter_sdk

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lokalise_flutter_sdk/lokalise_flutter_sdk.dart';
import 'intl/messages_all.dart';

class Lt {
  Lt._internal();

  static const LocalizationsDelegate<Lt> delegate = _AppLocalizationDelegate();

  static const List<Locale> supportedLocales = [
    Locale.fromSubtags(languageCode: 'en'),
    Locale.fromSubtags(languageCode: 'es'),
  ];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static Future<Lt> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    Lokalise.instance.metadata = _metadata;

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Lt._internal();
      return instance;
    });
  }

  static Lt of(BuildContext context) {
    final instance = Localizations.of<Lt>(context, Lt);
    assert(instance != null,
        'No instance of Tr present in the widget tree. Did you add Tr.delegate in localizationsDelegates?');
    return instance!;
  }

  static final Map<String, List<String>> _metadata = {
    'title': [],
    'list_title': [],
    'addButton': [],
    'title_addItem': [],
    'hint_addItem': [],
    'button_addItem': [],
    'total_todo': ['count'],
    'pending_todo': ['count'],
    'completed_todo': ['count']
  };

  /// `ToDo App`
  String get title {
    return Intl.message(
      'ToDo App',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Todo list`
  String get list_title {
    return Intl.message(
      'Todo list',
      name: 'list_title',
      desc: '',
      args: [],
    );
  }

  /// `Add Item`
  String get addButton {
    return Intl.message(
      'Add Item',
      name: 'addButton',
      desc: '',
      args: [],
    );
  }

  /// `Add a new todo item`
  String get title_addItem {
    return Intl.message(
      'Add a new todo item',
      name: 'title_addItem',
      desc: '',
      args: [],
    );
  }

  /// `Type your new todo`
  String get hint_addItem {
    return Intl.message(
      'Type your new todo',
      name: 'hint_addItem',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get button_addItem {
    return Intl.message(
      'Add',
      name: 'button_addItem',
      desc: '',
      args: [],
    );
  }

  /// `Total tasks: {count}`
  String total_todo(Object count) {
    return Intl.message(
      'Total tasks: $count',
      name: 'total_todo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, zero {You don't have pending tasks} one {You have just one pending task} other {You have {count} pending tasks}}`
  String pending_todo(num count) {
    return Intl.plural(
      count,
      zero: 'You don\'t have pending tasks',
      one: 'You have just one pending task',
      other: 'You have $count pending tasks',
      name: 'pending_todo',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, zero {You don't have completed tasks} one {You have just one completed task} other {You have {count} completed tasks}}`
  String completed_todo(num count) {
    return Intl.plural(
      count,
      zero: 'You don\'t have completed tasks',
      one: 'You have just one completed task',
      other: 'You have $count completed tasks',
      name: 'completed_todo',
      desc: '',
      args: [count],
    );
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<Lt> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => Lt.supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode);

  @override
  Future<Lt> load(Locale locale) => Lt.load(locale);

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
