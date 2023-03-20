import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class CircularCountdownWidget extends CustomPainter {
  final double percentage;
  final double borderWidth = 6;
  const CircularCountdownWidget({
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the gray background seen on the progress indicator
    // This will act as the background layer.
    canvas.drawCircle(
      center,
      size.width / 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.green.withOpacity(0.4)
        ..strokeWidth = borderWidth,
    );

    // Create a new layer where we will be painting the
    // actual progress indicator
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: 200, height: 200),
      Paint(),
    );

    // Draw the light green portion of the progress indicator
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      vmath.radians(-90),
      vmath.radians(percentage*360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Colors.green
        ..strokeWidth = borderWidth,
    );

    // Draw the dark green portion of the progress indicator
    // Basically, this covers the entire progress indicator circle.
    // But because we have set the blending mode to srouce-in (BlendMode.srcIn),
    // only the segment that is overlapping with the lighter portion will be visible.
    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      vmath.radians(0),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Colors.green
        ..strokeWidth = borderWidth
        ..blendMode = BlendMode.srcIn,
    );
    // we fatten the layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
