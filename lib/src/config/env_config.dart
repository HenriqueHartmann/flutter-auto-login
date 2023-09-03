import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> loadEnvFiles() async {
    await dotenv.load(fileName: "lib/src/config/.env");
  }
}
