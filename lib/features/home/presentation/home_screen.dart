import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text("Hello, Home Screen!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
