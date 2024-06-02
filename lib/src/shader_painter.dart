import 'package:flutter/material.dart';
import 'dart:ui';

abstract class ShaderPainter extends CustomPainter {
  final AnimationController controller;
  final FragmentShader shader;
  final int timeFactor;

  const ShaderPainter({
    required this.controller,
    required this.shader,
    required this.timeFactor,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, controller.value * timeFactor); // iTime
    shader.setFloat(1, size.width); // iResolution.x
    shader.setFloat(2, size.height); // iResolution.y

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
