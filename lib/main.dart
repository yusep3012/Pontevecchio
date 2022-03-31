import 'package:flutter/material.dart';

// Routes
import 'package:pontevecchio/routes/routes.dart';

// Theme
import 'package:pontevecchio/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pontevecchio',
      initialRoute: Routes.initialRoute,
      routes: Routes.getAppRoutes(),
      theme: AppTheme.lightTheme,
    );
  }
}
