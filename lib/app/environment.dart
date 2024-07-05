import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static String fileName(EnvironmentType type) {
    if (type == EnvironmentType.prod) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiScheme {
    return dotenv.env['API_SCHEME'] ?? 'API_SCHEME not found!';
  }

  static String get apiHost {
    return dotenv.env['API_HOST'] ?? 'API_HOST not found!';
  }

  static int get apiPort {
    return int.parse(dotenv.env['API_PORT']!);
  }

  static String get apiPrefix {
    return dotenv.env['API_PREFIX'] ?? 'API_PREFIX not found!';
  }

  static String get apiMediaUrl {
    return '$apiScheme://$apiHost:$apiPort/files/';
  }
}
