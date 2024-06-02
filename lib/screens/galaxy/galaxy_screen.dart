import 'package:custom_shaders/src/app_shaders.dart';
import 'package:custom_shaders/src/shader_painter.dart';
import 'package:custom_shaders/src/shader_view.dart';
import 'package:flutter/material.dart';

class GalaxyScreen extends StatelessWidget {
  static const _defaultDurationInSeconds = 60;

  const GalaxyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galaxy shader'),
      ),
      body: ShaderView(
        shader: AppShaders.galaxy,
        builder: (controller, shader, timeFactor) {
          return GalaxyPainter(
            controller: controller,
            shader: shader,
            timeFactor: timeFactor,
          );
        },
        durationInSeconds: _defaultDurationInSeconds,
      ),
    );
  }
}

class GalaxyPainter extends ShaderPainter {
  GalaxyPainter({
    required super.controller,
    required super.shader,
    required super.timeFactor,
  });
}
