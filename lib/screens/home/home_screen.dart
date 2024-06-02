import 'package:custom_shaders/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom shaders example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBtn(
              'snowflake shader',
              onPressed: () => _onSnowflakePressed(context),
            ),
            const SizedBox(height: 16),
            _buildBtn(
              'galaxy shader',
              onPressed: () => _onGalaxyPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(String text, {required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  void _onSnowflakePressed(BuildContext context) {
    _navigateTo(context, AppRoutes.snowflake);
  }

  void _onGalaxyPressed(BuildContext context) {
    _navigateTo(context, AppRoutes.galaxy);
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
