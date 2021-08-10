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
    path.moveTo(cx - 0.51 * width, cy - 0.03 * height);
    path.lineTo(cx - 0.40 * width, cy - 0.12 * height);

    path.lineTo(cx - 0.10 * width, cy + 0.25 * height);
    path.lineTo(cx + 0.64 * width, cy - 0.34 * height);

    path.lineTo(cx + 0.73 * width, cy - 0.22 * height);
    path.lineTo(cx - 0.12 * width, cy + 0.46 * height);
    path.lineTo(cx - 0.51 * width, cy - 0.03 * height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Arrow oldDelegate) {
    return true;
  }
}
