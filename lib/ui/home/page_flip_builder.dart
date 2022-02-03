import 'dart:math';

import 'package:flutter/material.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    Key? key,
    required this.frontPageBuilder,
    required this.backPageBuilder,
  }) : super(key: key);

  final WidgetBuilder frontPageBuilder;
  final WidgetBuilder backPageBuilder;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  bool _isFrontSide = true;

  void flip() {
    if (_isFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      setState(() {
        _isFrontSide = !_isFrontSide;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //logic to set front or back builder
    return AnimatedPageFlipBuilder(
      animation: _controller,
      isFrontSide: _isFrontSide,
      frontBuilder: widget.frontPageBuilder,
      backBuilder: widget.backPageBuilder,
    );
  }
}

class AnimatedPageFlipBuilder extends AnimatedWidget {
  const AnimatedPageFlipBuilder({
    Key? key,
    required Animation<double> animation,
    required this.isFrontSide,
    required this.frontBuilder,
    required this.backBuilder,
  }) : super(key: key, listenable: animation);

  final bool isFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    //animation values [0,1]
    //rotation valuse [0,pi]
    //show the front side for animation values between 0.0 and 0.5
    //show the back side for animation values between 0.5 and 1
    //add bolean variable that tells current side
    final isCurrentFrontSide = animation.value < 0.5;

    final child =
        isCurrentFrontSide ? frontBuilder(context) : backBuilder(context);
    final rotationValue = animation.value * pi;
    final rotationAngle =
        animation.value > 0.5 ? pi - rotationValue : rotationValue;
    double tiltValue = (animation.value - 0.5).abs() - 0.5;
    tiltValue *= isCurrentFrontSide ? -0.003 : 0.003;

    return Transform(
      transform: Matrix4.rotationY(rotationAngle)..setEntry(3, 0, tiltValue),
      alignment: Alignment.center,
      child: child,
    );
  }
}
