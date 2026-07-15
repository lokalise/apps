# Lokalise Flutter demo app

This is a very simple "todo" app created with Flutter that showcases the usage of Lokalise Flutter OTA SDK.

Blog post covering this app: https://lokalise.com/blog/lokalise-flutter-sdk-and-working-with-over-the-air-flow

Video tutorial: https://www.youtube.com/watch?v=QZexgRhFKic

More information can be found in the docs: https://developers.lokalise.com/docs/flutter-sdk

## Requirements

- Flutter 3.x (Dart 3). To prepare your dev environment, follow the [Flutter install docs](https://docs.flutter.dev/get-started/install).
- A Lokalise project with the [Lokalise OTA](https://developers.lokalise.com/docs/flutter-sdk) feature enabled.

## Running the app

1. Fill in your `projectId` and `sdkToken` in `lib/main.dart`.
2. Install dependencies: `flutter pub get`.
3. Run the app: `flutter run`.

## Regenerating localization files

After changing the `.arb` files in `lib/l10n`, regenerate the localization classes with:

```bash
dart run lokalise_flutter_sdk:gen-lok-l10n
```
