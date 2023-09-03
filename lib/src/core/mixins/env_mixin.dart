import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin EnvMixin {
  dynamic getEnvVariable({required String varName}) {
    return dotenv.env[varName];
  }
}
