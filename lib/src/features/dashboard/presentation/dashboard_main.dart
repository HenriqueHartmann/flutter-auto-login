import 'package:flutter/material.dart';

class DashboardMain extends StatelessWidget {
  const DashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        children: [
          Text('Dashboard'),
        ],
      ),
    );
  }
}