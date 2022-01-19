import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({Key? key, required this.progress})
      : super(key: key);
  final double progress;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final taskIsNotComplete = progress < 1.0;
    return AspectRatio(
      aspectRatio: 1.0,
      child: taskIsNotComplete
          ? CustomPaint(
              painter: RingPainter(
                  progress: progress,
                  taskNotCompletedColor: appTheme.taskRing,
                  taskCompletedColor: appTheme.accent),
            )
          : Container(
              decoration: BoxDecoration(
                color: appTheme.accent,
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}

class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.taskNotCompletedColor,
    required this.taskCompletedColor,
  });
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.width / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgrounPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgrounPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
