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
  CheckBoxTypes type;
  Color color;
  static const List<Color> colorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow
  ];

  @override
  void initState() {
    type = widget.type;
    color = colorsList[type.index];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //widget.cubit.selectCheckBox(widget.type);
        widget.checkBoxController.setCheckBoxType(type);
      },
      child: FittedBox(
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: CustomPaint(
            painter: ForeGroundCircle(color: color),
            child: Center(
              child: ValueListenableBuilder<int>(
                valueListenable: widget.checkBoxController.animationSpeed,
                builder: (context, duration, child) {
                  print("New duration: $duration");
                  return ValueListenableBuilder<CheckBoxTypes>(
                      valueListenable:
                          widget.checkBoxController.currentSelectedType,
                      builder: (context, curType, child) {
                        return AnimatedSwitcher(
                          key: ValueKey("$duration"),
                          duration: Duration(milliseconds: duration),
                          reverseDuration: Duration(milliseconds: duration),
                          switchInCurve: Curves.decelerate,
                          switchOutCurve: Curves.decelerate,
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: curType == widget.type
                              ? CustomPaint(
                                  key: ValueKey('1'),
                                  painter: Arrow(),
                                  child: Container(),
                                )
                              : CustomPaint(
                                  key: ValueKey('2'),
                                  painter: Circle(color: Colors.white),
                                  child: Container(),
                                ),
                        );
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
