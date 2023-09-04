import 'package:auto_login_app/src/core/config/env_config.dart';
import 'package:auto_login_app/src/core/config/injection_config.dart';
import 'package:auto_login_app/src/core/config/route_config.dart';
import 'package:flutter/material.dart';

Future main() async {
  await EnvConfig.loadEnvFiles();
  await InjectionConfig().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteConfig.generateRoute,
    );
  }
}
