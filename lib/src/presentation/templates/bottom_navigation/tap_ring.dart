// ignore_for_file: constant_identifier_names

import 'dart:math' as math;

import 'package:flutter/material.dart';

const double STROKE_WIDTH = 6;
const double TAP_INDICATOR_SIZE = 32;
const Duration TAP_ANIMATION_DURATION = Duration(milliseconds: 300);

class TapRing extends StatefulWidget {
  final double? strokeWidth;
  final double? size;
  final Color? color;
  final bool? isSelected;

  const TapRing(
      {this.isSelected,
      this.color,
      this.strokeWidth = STROKE_WIDTH,
      this.size = TAP_INDICATOR_SIZE,
      Key? key})
      : super(key: key);

  @override
  _TapRingState createState() => _TapRingState();
}

class _TapRingState extends State<TapRing> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: TAP_ANIMATION_DURATION,
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(widget.strokeWidth!),
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                var size = _animation.value * widget.size!;
                if (size == widget.size) size = 0;

                return CustomPaint(
                  size: Size(size, size),
                  foregroundPainter: RingPainter(
                    strokeWidth: widget.strokeWidth!,
                    animationProgress: _animation.value,
                    color: widget.color!,
                  ),
                );
              }),
        );
      },
    );
  }

  @override
  void didUpdateWidget(TapRing oldWidget) {
    if (!oldWidget.isSelected! && widget.isSelected!) {
      controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }
}

class RingPainter extends CustomPainter {
  final double? animationProgress;
  final double? strokeWidth;
  final Color? color;

  RingPainter({this.strokeWidth, this.animationProgress, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    var startAngle = -math.pi / 2;
    final fullCircleSweepAngle = math.pi * 2;
    const useCenter = false;
    final paint = Paint()
      ..color = color!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth! * (1 - animationProgress!);

    canvas.drawArc(rect, startAngle, fullCircleSweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress;
  }
}
