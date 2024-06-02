import 'dart:ui';

import 'package:custom_shaders/src/shader_painter.dart';
import 'package:flutter/material.dart';

typedef ShaderViewBuilder = ShaderPainter Function(
  AnimationController controller,
  FragmentShader shader,
  int timeFactor,
);

class ShaderView extends StatefulWidget {
  final String shader;
  final ShaderViewBuilder builder;
  final int durationInSeconds;

  const ShaderView({
    super.key,
    required this.shader,
    required this.builder,
    required this.durationInSeconds,
  });

  @override
  State<ShaderView> createState() => _ShaderViewState();
}

class _ShaderViewState extends State<ShaderView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    )..repeat();

    _loadShader();
  }

  Future<void> _loadShader() async {
    final program = await FragmentProgram.fromAsset(widget.shader);
    setState(() {
      _shader = program.fragmentShader();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shader = _shader;
    return CustomPaint(
      painter: shader != null
          ? widget.builder(
              _controller,
              shader,
              widget.durationInSeconds,
            )
          : null,
      child: Container(),
    );
  }
}
