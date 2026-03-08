import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String get wsBaseUrl =>
      dotenv.env['WS_BASE_URL'] ?? 'ws://192.168.0.33';

  static String get wsBasePort =>
      dotenv.env['WS_BASE_PORT'] ?? '9090';
}
