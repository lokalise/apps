import 'package:flutter/material.dart';
import 'package:to_do_app/app/views/screens/todo_screen/todo_screen.dart';
import 'package:to_do_app/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => Lt.of(context).title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      localizationsDelegates: Lt.localizationsDelegates,
      supportedLocales: Lt.supportedLocales,
      home: TodoScreen(),

      // By default, the app will pick the device locale,
      // if you want to force a specific locale, you can use:
      // locale: const Locale('es')
    );
  }
}
