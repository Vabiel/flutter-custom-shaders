import 'package:custom_shaders/src/app_shaders.dart';
import 'package:custom_shaders/src/shader_painter.dart';
import 'package:custom_shaders/src/shader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class SnowflakeScreen extends StatefulWidget {
  static const _defaultDurationInSeconds = 10;

  const SnowflakeScreen({super.key});

  @override
  State<SnowflakeScreen> createState() => _SnowflakeScreenState();
}

class _SnowflakeScreenState extends State<SnowflakeScreen> {
  Color _backgroundColor = Colors.blue;
  Color _snowflakeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snowflake shader'),
        actions: [
          IconButton(
            onPressed: () => _onChangeSnowflakeColor(context),
            icon: const Icon(Icons.ac_unit_outlined),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _onChangeBackgroundColor(context),
            icon: const Icon(Icons.color_lens),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ShaderView(
        shader: AppShaders.snowflake,
        builder: (controller, shader, timeFactor) {
          return SnowflakePainter(
            controller: controller,
            shader: shader,
            timeFactor: timeFactor,
            backgroundColor: _backgroundColor,
            snowflakeColor: _snowflakeColor,
          );
        },
        durationInSeconds: SnowflakeScreen._defaultDurationInSeconds,
      ),
    );
  }

  void _onChangeSnowflakeColor(BuildContext context) {
    _showColorDialog(context, _snowflakeColor, (color) {
      setState(() {
        _snowflakeColor = color;
      });
    });
  }

  void _onChangeBackgroundColor(BuildContext context) {
    _showColorDialog(context, _backgroundColor, (color) {
      setState(() {
        _backgroundColor = color;
      });
    });
  }

  void _showColorDialog(BuildContext context, Color selectedColor,
      ValueChanged<Color> onChanged) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ColorPicker(
                          color: selectedColor,
                          pickerOrientation: PickerOrientation.portrait,
                          initialPicker: Picker.paletteValue,
                          onChanged: onChanged,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class SnowflakePainter extends ShaderPainter {
  final Color backgroundColor;
  final Color snowflakeColor;

  SnowflakePainter({
    required super.controller,
    required super.shader,
    required super.timeFactor,
    required this.backgroundColor,
    required this.snowflakeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Передача цветов в шейдер
    shader.setFloat(3, backgroundColor.red / 255.0);
    shader.setFloat(4, backgroundColor.green / 255.0);
    shader.setFloat(5, backgroundColor.blue / 255.0);
    shader.setFloat(6, backgroundColor.alpha / 255.0);
    shader.setFloat(7, snowflakeColor.red / 255.0);
    shader.setFloat(8, snowflakeColor.green / 255.0);
    shader.setFloat(9, snowflakeColor.blue / 255.0);
    shader.setFloat(10, snowflakeColor.alpha / 255.0);

    super.paint(canvas, size);
  }
}
