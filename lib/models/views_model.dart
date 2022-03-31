import 'package:flutter/material.dart' show Widget;

class ViewOptions {
  final String route;
  final String name;
  final Widget screen;

  ViewOptions({
    required this.route,
    required this.name,
    required this.screen,
  });
}
