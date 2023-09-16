import 'package:auto_login_app/src/app.dart';
import 'package:auto_login_app/src/core/config/env_config.dart';
import 'package:auto_login_app/src/core/config/injection_config.dart';
import 'package:flutter/material.dart';

Future main() async {
  await EnvConfig.loadEnvFiles(EnvEnum.dev);
  await InjectionConfig.init();
  runApp(const MyApp());
}
