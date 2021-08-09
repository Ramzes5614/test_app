import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_app/components/checkbox_widget.dart';
import 'package:test_app/components/common_button.dart';
import 'package:test_app/controller/checkbox_conroller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _value;
  List<Widget> _checkBoxes;
  ScrollController controller = ScrollController();
  bool boxIsScrolled = false;
  CheckBoxTypes selectedType;
  CheckBoxController _checkBoxController = CheckBoxController();
  Timer _timer;

  @override
  void initState() {
    _value = _checkBoxController.animationSpeed.toDouble();
    selectedType = CheckBoxTypes.green;
    _checkBoxes = List<CheckBoxWidget>.generate(
      3,
      (index) => CheckBoxWidget(
        type: CheckBoxTypes.values[Random().nextInt(3)],
        checkBoxController: _checkBoxController,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: SingleChildScrollView(
              reverse: true,
              primary: true,
              child: Column(
                children: [
                  GridView.count(
                    padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                    controller: controller,
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: _checkBoxes,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Slider(
                      value: _value,
                      max: 3000,
                      min: 1,
                      onChanged: (value) {
                        _timer?.cancel();
                        _timer = Timer(Duration(milliseconds: 100), () {
                          _checkBoxController.setAnimationSpeed(
                            value.toInt(),
                          );
                          print("new duration: $value");
                        });

                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                  Text('${_value.toInt()} мс'),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                            ontap: () {
                              _addRandomBoxes();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add checkboxes",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: CommonButton(
                              ontap: () {
                                _checkBoxes.clear();
                                setState(() {
                                  _checkBoxes = [];
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Clear",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addRandomBoxes() {
    setState(() {
      _checkBoxes = [
        ..._checkBoxes,
        ...List<CheckBoxWidget>.generate(
          10,
          (index) => CheckBoxWidget(
              checkBoxController: _checkBoxController,
              type: CheckBoxTypes.values[Random().nextInt(3)]),
        )
      ];
    });
  }
}
