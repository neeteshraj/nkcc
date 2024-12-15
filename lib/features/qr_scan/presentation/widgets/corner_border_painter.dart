import 'package:flutter/material.dart';

class CornerBorderPainter extends CustomPainter {
  final double radius;
  final double borderWidth;
  final Color borderColor;

  CornerBorderPainter({
    required this.radius,
    required this.borderWidth,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final cornerOffset = radius / 2;

    final path = Path();

    path.addArc(Rect.fromCircle(center: Offset(cornerOffset, cornerOffset), radius: radius), 3 * 3.14 / 2, 3.14 / 2);

    path.addArc(Rect.fromCircle(center: Offset(size.width - cornerOffset, cornerOffset), radius: radius), 3.14 / 2, 3.14 / 2);

    path.addArc(Rect.fromCircle(center: Offset(size.width - cornerOffset, size.height - cornerOffset), radius: radius), 0, 3.14 / 2);

    path.addArc(Rect.fromCircle(center: Offset(cornerOffset, size.height - cornerOffset), radius: radius), 3.14, 3.14 / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
