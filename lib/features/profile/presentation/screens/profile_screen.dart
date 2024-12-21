import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text("Hello, Profile Screen!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
