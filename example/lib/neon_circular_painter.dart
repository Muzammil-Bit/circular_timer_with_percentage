import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    required this.backgroundColor,
    this.strokeWidth = 3.0,
    this.strokeCap,
    required this.percentageBackgroundColor,
    required this.progressLineColor,
    required this.progressTextStyle,
  }) : super(repaint: animation);

  final Animation<double>? animation;
  final Color backgroundColor;
  final double strokeWidth;
  final StrokeCap? strokeCap;
  final Color percentageBackgroundColor;
  final Color progressLineColor;
  final TextStyle progressTextStyle;

  @override
  void paint(Canvas canvas, Size size) {
    double progress = (animation!.value) * 2 * math.pi;

    // Background White Circle
    Paint bgCircle = Paint()..color = backgroundColor;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 2,
      bgCircle,
    );
    Paint progressLine = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = progressLineColor
      ..style = PaintingStyle.stroke;

    Path path = Path();

    path.addArc(Offset.zero & size, math.pi * 1.5, progress);
    canvas.drawPath(path, progressLine);

    Paint innerCircle = Paint()
      ..color = percentageBackgroundColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver;

    canvas.drawCircle(calculateProgressBackgroundPosition(progress, path, size), size.width / 13, innerCircle);

    final textPainter = TextPainter(
      text: TextSpan(
        text: "${(progress / 6.28 * 100).toStringAsFixed(0)}%",
        style: progressTextStyle,
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: size.width / 8,
      maxWidth: size.width / 8,
    );

    textPainter.paint(canvas, calculateProgressTextPosition(progress, path, size));
  }

  Offset calculateProgressBackgroundPosition(value, Path path, Size size) {
    if (path.computeMetrics().isNotEmpty) {
      PathMetric pathMetric = path.computeMetrics().elementAt(0);
      value = pathMetric.length * value + 20;
      Tangent pos = pathMetric.getTangentForOffset(value)!;
      return pos.position;
    }
    return Offset(size.width / 2, 0);
  }

  Offset calculateProgressTextPosition(value, Path path, Size size) {
    if (path.computeMetrics().isNotEmpty) {
      PathMetric pathMetric = path.computeMetrics().elementAt(0);
      value = pathMetric.length * value + 20;
      Tangent pos = pathMetric.getTangentForOffset(value)!;

      Offset of = Offset(pos.position.dx - 12, pos.position.dy - 4);
      return of;
    }
    return Offset(size.width / 2 - 11, -5);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation!.value != old.animation!.value;
  }
}
