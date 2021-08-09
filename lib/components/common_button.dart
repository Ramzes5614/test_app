import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {this.backGroundColor = Colors.green,
      this.height = 45,
      this.width,
      this.ontap,
      this.borderRadius = const BorderRadius.all(
        Radius.circular(15),
      ),
      this.shape = BoxShape.rectangle,
      this.padding = const EdgeInsets.only(top: 16, bottom: 16),
      this.child});
  final Color backGroundColor;
  final double height;
  final double width;
  final Function ontap;
  final BorderRadiusGeometry borderRadius;
  final BoxShape shape;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor, borderRadius: borderRadius, shape: shape),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
