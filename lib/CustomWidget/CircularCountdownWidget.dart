import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularCountdownWidget extends StatefulWidget {
  final AnimationController? animationController;

  const CircularCountdownWidget({Key? key, this.animationController})
      : super(key: key);

  @override
  CircularCountdownWidgetState createState() => CircularCountdownWidgetState();
}

class CircularCountdownWidgetState extends State<CircularCountdownWidget>
    with TickerProviderStateMixin {
  AnimationController? controller;

  String timerString() {
    Duration duration = controller!.duration! * controller!.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    controller = widget.animationController;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (context, child) {
          return SizedBox(
            child: CustomPaint(
              painter: CountDownCirclePainter(animation: controller),
              child: Center(
                child: Text(
                  timerString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CountDownCirclePainter extends CustomPainter {
  CountDownCirclePainter({
    this.animation,
  }) : super(repaint: animation);
  final Animation<double>? animation;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(.2)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = Colors.blue;
    paint.strokeWidth = 30;
    double progress = (0 + animation!.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(CountDownCirclePainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value;
  }
}