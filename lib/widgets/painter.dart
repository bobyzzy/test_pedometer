import 'package:flutter/material.dart';

import 'custom_painter.dart';

class Painter extends StatelessWidget {
  final int currentSteps;
  final int totalSteps;

  const Painter({
    required this.currentSteps,
    required this.totalSteps,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = totalSteps > 0 ? currentSteps / totalSteps : 0.0;

    return Container(
      width: 100,
      height: 100,
      child: RadialPercentWidget(
        percent: percentage,
        fillColor: Color.fromARGB(255, 10, 23, 25),
        lineColor: Color.fromARGB(255, 37, 203, 103),
        fillSpaceColor: Color.fromARGB(255, 25, 54, 31),
        lineWidth: 3,
        child: Text(
          '${(percentage * 100).toInt()}%',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
