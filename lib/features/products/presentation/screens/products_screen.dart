import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text("Hello, Products Screen!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
