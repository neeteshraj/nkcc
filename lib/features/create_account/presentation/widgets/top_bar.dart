import 'package:flutter/material.dart';
import 'package:support/core/constants/images_paths.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 16,
      child: Row(
        children: [
          IconButton(
            icon: Image.asset(
              ImagesPaths.arrowBack,
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
