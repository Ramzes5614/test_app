import 'package:flutter/material.dart';

class ForeGroundCircle extends CustomPainter {
  ForeGroundCircle({this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    final double radius = height / 2;

    var paint = Paint()..color = color;
    canvas.drawCircle(Offset(size.height / 2, size.width / 2), radius, paint);
  }

  @override
  bool shouldRepaint(ForeGroundCircle oldDelegate) {
    return true;
  }
}