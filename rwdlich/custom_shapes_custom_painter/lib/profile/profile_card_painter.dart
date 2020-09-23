import 'package:flutter/material.dart';
import 'dart:math';
import '../extensions.dart';

class ProfileCardPainter extends CustomPainter {
  ProfileCardPainter({@required this.color, @required this.avatarRadius});

  final Color color;
  final double avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds =
        Rect.fromLTRB(0, 0, size.width, size.height - avatarRadius);

    final centerAvatar = Offset(shapeBounds.center.dx, shapeBounds.bottom);

    final avatarBounds =
        Rect.fromCircle(center: centerAvatar, radius: avatarRadius).inflate(6);

    _drawBackground(canvas, shapeBounds, avatarBounds);

    final curvedShapeBounds = Rect.fromLTRB(
      shapeBounds.left,
      shapeBounds.top + shapeBounds.height * 0.35,
      shapeBounds.right,
      shapeBounds.bottom,
    );

    _drawCurvedShape(canvas, curvedShapeBounds, avatarBounds);
  }

  @override
  bool shouldRepaint(ProfileCardPainter oldDelegate) {
    return color != oldDelegate.color;
  }

  void _drawBackground(Canvas canvas, Rect shapeBounds, Rect avatarBounds) {
    final paint = Paint()..color = color;

    final backgroundPath = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top) //3
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy) //4
      ..arcTo(avatarBounds, -pi, pi, false) //5
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottomRight.dy) //6
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy) //7
      ..close(); //8

    canvas.drawPath(backgroundPath, paint);
  }

  void _drawCurvedShape(Canvas canvas, Rect bounds, Rect avatarBounds) {
    final colors = [color.darker(), color, color.darker()];

    final stops = [0.0, 0.3, 1.0];

    final gradient = LinearGradient(colors: colors, stops: stops);

    final paint = Paint()..shader = gradient.createShader(bounds);

    final handlePoint = Offset(bounds.left + (bounds.width * 0.25), bounds.top);

    final curvePath = Path()
      ..moveTo(bounds.bottomLeft.dx, bounds.bottomLeft.dy) //4
      ..arcTo(avatarBounds, -pi, pi, false) //5
      ..lineTo(bounds.bottomRight.dx, bounds.bottomRight.dy) //6
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy) //7
      ..quadraticBezierTo(handlePoint.dx, handlePoint.dy, bounds.bottomLeft.dx,
          bounds.bottomLeft.dy) //8
      ..close(); //9

    canvas.drawPath(curvePath, paint);
  }
}
