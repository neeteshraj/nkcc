import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text("Hello, Services Screen!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
