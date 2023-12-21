// ignore_for_file: file_names
import 'dart:math';
import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color fillSpaceColor;
  final double lineWidth;
  const RadialPercentWidget({
    super.key,
    required this.child,
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.fillSpaceColor,
    required this.lineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent,
            fillColor: fillColor,
            fillSpaceColor: fillSpaceColor,
            lineColor: lineColor,
            lineWidth: lineWidth,
          ),
        ),
        Center(child: child),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color fillSpaceColor;
  final double lineWidth;

  const MyPainter({
    required this.percent,
    required this.fillColor,
    required this.lineColor,
    required this.fillSpaceColor,
    required this.lineWidth,
  });

  void fillPainter(Canvas canvas, Rect arcRect) {
    final fillPainter = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, pi * 2 * percent, false, fillPainter);
  }

  void fillSpacePainter(Canvas canvas, Rect arcRect) {
    final fillSpacePainter = Paint()
      ..color = fillSpaceColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      fillSpacePainter,
    );
  }

  void coloringBackround(Canvas canvas, Size size) {
    final backgroundPainter = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPainter);
  }

  //! меняет позицию линий в круге исходя из положения свойство линий если нужно поменять тут что это числа которые там стоят
  Rect calculateActRect(Size size) {
    const marginLine = 7;
    final offset = lineWidth / 2 + marginLine;
    final arcRect = Offset(offset, offset) & Size(size.width - 16, size.height - 16);
    return arcRect;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = calculateActRect(size);
    coloringBackround(canvas, size);
    fillSpacePainter(canvas, arcRect);
    fillPainter(canvas, arcRect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
