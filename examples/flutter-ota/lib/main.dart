import 'package:flutter/material.dart';
import 'package:lokalise_flutter_sdk/ota/lokalise_sdk.dart';
import 'package:to_do_app/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Lokalise.init(
    projectId: '', // Fill with your project id
    sdkToken: '', // Fill with your SDK token
  );
  runApp(const App());
}
