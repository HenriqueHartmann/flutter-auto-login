import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvEnum {
  dev,
  prod;

  String get getName {
    switch (this) {
      case EnvEnum.dev:
        return "dev";
      case EnvEnum.prod:
        return "prod";
    }
  }
}

class EnvConfig {
  static Future<void> loadEnvFiles(EnvEnum flavor) async {
    await dotenv.load(fileName: "lib/src/core/config/${flavor.getName}.env");
  }
}
