// GENERATED CODE
//
// After the template files .arb have been changed (lib/l10/),
// generate this class by the command in the terminal:
// tr
// Please see https://pub.dev/packages/lokalise_flutter_sdk

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lokalise_flutter_sdk/ota/lokalise_sdk.dart';
import 'intl/messages_all.dart';

class Tr {
  Tr();

  static Tr? _current;

  static Tr get current {
    assert(_current != null,
        'No instance of Tr was loaded. Try to initialize the Tr delegate before accessing Tr.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Tr> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    if (!Lokalise.hasMetadata()) {
      Lokalise.setMetadata(_metadata);
    }
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Tr();
      Tr._current = instance;

      return instance;
    });
  }

  static Tr of(BuildContext context) {
    final instance = Tr.maybeOf(context);
    assert(instance != null,
        'No instance of Tr present in the widget tree. Did you add Tr.delegate in localizationsDelegates?');
    return instance!;
  }

  static Tr? maybeOf(BuildContext context) {
    return Localizations.of<Tr>(context, Tr);
  }

  static final Map<String, List<String>> _metadata = {
    'title': [],
    'list_title': [],
    'addButton': [],
    'title_addItem': [],
    'hint_addItem': [],
    'button_addItem': []
  };

  /// `Another ToDo App`
  String get title {
    return Intl.message(
      'Another ToDo App',
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<Tr> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Tr> load(Locale locale) => Tr.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes
