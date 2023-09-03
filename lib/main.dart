import 'package:auto_login_app/src/utils/env_client.dart';
import 'package:auto_login_app/src/utils/route_generator.dart';
import 'package:flutter/material.dart';

Future main() async {
  await EnvClient.loadEnvFiles();
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
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
