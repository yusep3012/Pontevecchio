import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Routes
import 'package:pontevecchio/routes/routes.dart';

// Theme
import 'package:pontevecchio/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
