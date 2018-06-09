import 'dart:math' as math;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  ProgressPainter({
    @required this.animation,
    @required this.backgroundColor,
    @required this.color,
  }) : super(repaint: animation);

  /// Animation representing what we are painting
  final Animation<double> animation;

  /// The color in the background of the circle
  final Color backgroundColor;

  /// The foreground color used to indicate progress
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = backgroundColor
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    paint.color = color;
    double progressRadians = (1.0 - animation.value) * 2 * math.PI;
    canvas.drawArc(Offset.zero & size, math.PI * 1.5, -progressRadians, false, paint);
  }

  @override
  bool shouldRepaint(ProgressPainter other) {
    return animation.value != other.animation.value ||
        color != other.color ||
        backgroundColor != other.backgroundColor;
  }
}
