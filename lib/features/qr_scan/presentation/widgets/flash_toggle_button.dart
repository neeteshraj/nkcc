import 'package:flutter/material.dart';

class FlashToggleButton extends StatelessWidget {
  final bool isFlashOn;
  final Function() onPressed;

  const FlashToggleButton({
    Key? key,
    required this.isFlashOn,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFlashOn ? Icons.flash_off : Icons.flash_on,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
