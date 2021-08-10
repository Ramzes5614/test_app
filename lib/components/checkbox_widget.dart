import 'package:flutter/material.dart';
import 'package:test_app/components/custom_paint_arrow.dart';
import 'package:test_app/components/custom_paint_circle.dart';
import 'package:test_app/components/custom_paint_foreground_circle.dart';
import 'package:test_app/controller/checkbox_conroller.dart';

class CheckBoxWidget extends StatefulWidget {
  CheckBoxWidget(
      {@required this.checkBoxController, @required this.type, this.size = 18});
  final CheckBoxTypes type;
  final double size;
  final CheckBoxController checkBoxController;
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget>
    with TickerProviderStateMixin {
  static const List<Color> colorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow
  ];
  Color color;
  AnimationController animationController;
  Animation<double> scaleAnimation;
  Duration duration;
  bool isSelected;

  Widget arrowWidget = CustomPaint(
    key: ValueKey('1'),
    painter: Arrow(),
    child: Container(),
  );

  Widget circleWidget = CustomPaint(
    key: ValueKey('2'),
    painter: Circle(color: Colors.white),
    child: Container(),
  );
  Widget currentChild;

  @override
  void initState() {
    color = colorsList[widget.type.index];
    isSelected =
        widget.checkBoxController.currentSelectedType.value == widget.type;
    currentChild = isSelected ? arrowWidget : circleWidget;

    widget.checkBoxController.animationSpeed.addListener(durationListener);
    widget.checkBoxController.currentSelectedType.addListener(typeListener);

    duration =
        Duration(milliseconds: widget.checkBoxController.animationSpeed.value);

    animationController = AnimationController(
        vsync: this,
        animationBehavior: AnimationBehavior.preserve,
        duration: duration);

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (widget.checkBoxController.currentSelectedType.value ==
                  widget.type) {
                currentChild = arrowWidget;
                isSelected = true;
              } else {
                currentChild = circleWidget;
                isSelected = false;
              }
              if (duration.inMilliseconds !=
                  widget.checkBoxController.animationSpeed.value) {
                duration = Duration(
                    milliseconds:
                        widget.checkBoxController.animationSpeed.value);
                animationController.duration = duration;
              }
              setState(() {});
              animationController.reverse();
            }
          });

    super.initState();
  }

  void durationListener() {
    if (!animationController.isAnimating)
      setState(() {
        duration = Duration(
            milliseconds: widget.checkBoxController.animationSpeed.value);
        animationController.duration = duration;
      });
  }

  void typeListener() {
    if (isSelected) {
      if (widget.checkBoxController.currentSelectedType.value != widget.type) {
        animationController.forward();
      }
    } else {
      if (widget.checkBoxController.currentSelectedType.value == widget.type) {
        animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    widget.checkBoxController.animationSpeed.removeListener(durationListener);
    widget.checkBoxController.currentSelectedType.removeListener(typeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!animationController.isAnimating) {
          widget.checkBoxController.setCheckBoxType(widget.type);
        }
      },
      child: FittedBox(
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: CustomPaint(
            painter: ForeGroundCircle(color: color),
            child: Center(
              child: ScaleTransition(
                key: ValueKey("$duration"),
                scale: scaleAnimation,
                child: currentChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
