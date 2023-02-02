import 'package:flutter/material.dart';
import 'package:lokalise_flutter_sdk/ota/lokalise_sdk.dart';
import 'package:to_do_app/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Lokalise.init(
    sdkToken: 'd24a6c4e93076b29e71347e8c39713f87f1e',
    projectId: '595412416388cd7cdebfe5.92023764',
  );
  runApp(const App());
}
