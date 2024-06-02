import 'package:custom_shaders/screens/galaxy/galaxy_screen.dart';
import 'package:custom_shaders/screens/home/home_screen.dart';
import 'package:custom_shaders/screens/snowflake/snowflake_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    snowflake: (context) => const SnowflakeScreen(),
    galaxy: (context) => const GalaxyScreen(),
  };

  static const home = '/';
  static const snowflake = '/snowflake';
  static const galaxy = '/galaxy';
}
