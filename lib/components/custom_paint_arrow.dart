import 'package:flutter/material.dart';

class Arrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height / 2;
    double width = size.width / 2;
    double cx = size.width / 2.2;
    double cy = size.height / 2;

    var paint = Paint()..color = Colors.white;

    Path path = Path();
    path.moveTo(cx, cy);
    path.lineTo(cx + 0.75 * width, cy - 0.61 * height);
    path.lineTo(cx + 0.75 * width, cy - 0.44 * height);
    path.lineTo(cx - 0.03 * width, cy + 0.19 * height);

    path.lineTo(cx - 0.3 * width, cy - 0.24 * height);
    path.lineTo(cx - 0.2 * width, cy - 0.32 * height);
    path.lineTo(cx, cy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Arrow oldDelegate) {
    return true;
  }
}