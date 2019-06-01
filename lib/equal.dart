import 'package:flutter/material.dart';

import 'themes.dart';

class Equal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomPaint(
            painter: EqualPainter(),
          ),
        ),
      ),
    );
  }
}

class EqualPainter extends CustomPainter {
  static double strokeWidth = 12.0;
  var _paint = Paint()
    ..color = accentColor
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    var dy = (size.height - 2 * strokeWidth) / 3;
    canvas.drawLine(Offset(0.0, dy), Offset(size.width, dy), _paint);
    canvas.drawLine(Offset(0.0, 2 * dy + strokeWidth),
        Offset(size.width, 2 * dy + strokeWidth), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
