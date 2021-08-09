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
  bool _isSelected;
  CheckBoxTypes type;
  Color color;
  Duration _duration;
  static const List<Color> colorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow
  ];

  @override
  void initState() {
    type = widget.type;
    color = colorsList[type.index];
    _isSelected = widget.type == widget.checkBoxController.currentSelectedType;
    _duration =
        Duration(milliseconds: widget.checkBoxController.animationSpeed);
    widget.checkBoxController.addListener(listener);
    super.initState();
  }

  void listener() {
    setState(() {
      this._isSelected =
          widget.checkBoxController.currentSelectedType == widget.type;
      this._duration =
          Duration(milliseconds: widget.checkBoxController.animationSpeed);
    });
  }

  @override
  void dispose() {
    widget.checkBoxController.removeListener(listener);
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
              child: AnimatedSwitcher(
                duration: _duration,
                reverseDuration: _duration,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: _isSelected
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
