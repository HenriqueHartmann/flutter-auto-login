import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvClient {
  static Future<void> loadEnvFiles() async {
    await dotenv.load(fileName: "lib/src/config/.env");
  }

  static dynamic getEnvVariable({required String varName}) {
    return dotenv.env[varName];
  }
}
