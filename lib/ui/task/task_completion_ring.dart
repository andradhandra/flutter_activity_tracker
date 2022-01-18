import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
