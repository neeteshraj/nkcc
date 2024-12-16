import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:support/core/constants/lottie_path.dart';

class ScanAnimation extends StatefulWidget {
  final double height;
  final double playbackSpeed;

  const ScanAnimation({
    super.key,
    this.height = 100.0,
    this.playbackSpeed = 2.0,
  });

  @override
  _ScanAnimationState createState() => _ScanAnimationState();
}

class _ScanAnimationState extends State<ScanAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRect(  // This widget clips the child (Lottie animation) to its size.
        child: SizedBox(
          height: widget.height, // Set the container's height
          child: Lottie.asset(
            LottiePaths.scanLottie,
            width: double.infinity, // Keep the width to take up the full container
            fit: BoxFit.cover,
            controller: _animationController,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration * (1 / widget.playbackSpeed)
                ..repeat();
            },
          ),
        ),
      ),
    );
  }
}
