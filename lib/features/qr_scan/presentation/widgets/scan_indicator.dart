import 'package:flutter/material.dart';
import 'package:support/core/constants/images_paths.dart';

class ScanIndicator extends StatelessWidget {
  const ScanIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blueAccent,
          child: Image.asset(
            ImagesPaths.scanIcon,
            width: 32,
            height: 32,
          ),
        ),
      ),
    );
  }
}
