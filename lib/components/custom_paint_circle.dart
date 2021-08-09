import 'package:flutter/material.dart';

class Circle extends CustomPainter {
  Circle({this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height - 2;
    double width = size.width - 2;
    final double radius = height / 2;
    print("Size: $height, $width");

    var paint = Paint()..color = color;
    canvas.drawCircle(Offset(size.height / 2, size.width / 2), radius, paint);
  }

  @override
  bool shouldRepaint(Circle oldDelegate) {
    return true;
  }
}
