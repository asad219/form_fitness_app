/// Values from the env file:
/// `flutter run --dart-define-from-file=env/dev.json`
class EnvConfig {
  EnvConfig._();

  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
  );
  static const String apiVersion = String.fromEnvironment(
    'API_VERSION',
    defaultValue: 'v1',
  );

  /// Set to false to run without Firebase.
  static const bool enableFirebase = bool.fromEnvironment(
    'ENABLE_FIREBASE',
    defaultValue: true,
  );

  /// Firebase Web API keys, used by lib/firebase_options.dart. They only
  /// identify the Firebase project, so they are safe to build into the app,
  /// but they stay out of git so secret scanning doesn't flag them.
  static const String firebaseApiKeyAndroid = String.fromEnvironment(
    'FIREBASE_API_KEY_ANDROID',
  );
  static const String firebaseApiKeyIos = String.fromEnvironment(
    'FIREBASE_API_KEY_IOS',
  );

  static bool get isDev =>
      environment ==
      'dev';
  static bool get isStaging =>
      environment ==
      'staging';
  static bool get isProd =>
      environment ==
      'prod';

  /// Error message if the config is wrong, or `null` if it's fine.
  /// The app shows it on a setup screen at startup.
  static String? get configurationError {
    if (baseUrl.isEmpty) {
      return 'BASE_URL is not set.\n\n'
          'Copy env/dev.json.example to env/dev.json, set BASE_URL, then run:\n'
          'flutter run --dart-define-from-file=env/dev.json';
    }
    final uri = Uri.tryParse(
      baseUrl,
    );
    if (uri ==
            null ||
        !uri.hasScheme ||
        uri.host.isEmpty) {
      return 'BASE_URL "$baseUrl" is not a valid URL.\n\n'
          'Use a full URL such as https://api.example.com';
    }
    if (enableFirebase &&
        (firebaseApiKeyAndroid.isEmpty ||
            firebaseApiKeyIos.isEmpty)) {
      return 'FIREBASE_API_KEY_ANDROID and FIREBASE_API_KEY_IOS are not set.\n\n'
          'Copy them from the Firebase console (Project settings > General) '
          'into your env file, or set "ENABLE_FIREBASE": false.';
    }
    return null;
  }
}
