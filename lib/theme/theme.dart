import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff2E305F);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme:
        const AppBarTheme(color: primary, elevation: 0, centerTitle: true),
  );
}
