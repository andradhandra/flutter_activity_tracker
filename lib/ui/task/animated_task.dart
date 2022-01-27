import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({Key? key, required this.iconName}) : super(key: key);
  final String iconName;

  @override
  _TickerAnimationState createState() => _TickerAnimationState();
}

class _TickerAnimationState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curveAnimation;
  bool _showCheckIcon = false;

  void _onTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else if (!_showCheckIcon) {
      _animationController.value = 0;
    }
  }

  void _onAnimationCancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _checkStatusUpdate(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() {
          _showCheckIcon = true;
        });
      }
      Future.delayed(
        Duration(seconds: 1),
        () {
          if (mounted) {
            setState(
              () {
                _showCheckIcon = false;
              },
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _animationController.addStatusListener(_checkStatusUpdate);
    _curveAnimation = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_checkStatusUpdate);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (_) => _onAnimationCancel(),
      onTapCancel: _onAnimationCancel,
      child: AnimatedBuilder(
        animation: _curveAnimation,
        builder: (context, child) {
          final themeData = AppTheme.of(context);
          final progress = _curveAnimation.value;
          final taskIsNotComplete = progress < 1.0;
          final iconColor =
              taskIsNotComplete ? themeData.taskIcon : themeData.accentNegative;
          return Stack(
            children: [
              TaskCompletionRing(
                progress: progress,
              ),
              Positioned.fill(
                child: CenteredSvgIcon(
                  iconName: !taskIsNotComplete && _showCheckIcon
                      ? AppAssets.check
                      : widget.iconName,
                  color: iconColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
