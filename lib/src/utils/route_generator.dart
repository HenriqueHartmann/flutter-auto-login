import 'package:auto_login_app/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:auto_login_app/src/features/login/presentation/login_main.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardMain());
      default:
        return MaterialPageRoute(builder: (_) => const LoginMain());
    }
  }
}
