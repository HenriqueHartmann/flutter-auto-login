import 'package:auto_login_app/src/config/env_config.dart';
import 'package:auto_login_app/src/config/route_config.dart';
import 'package:flutter/material.dart';

Future main() async {
  await EnvConfig.loadEnvFiles();
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
