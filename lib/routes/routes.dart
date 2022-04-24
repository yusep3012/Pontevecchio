import 'package:flutter/material.dart';

// Models
import 'package:pontevecchio/models/models.dart';
import 'package:pontevecchio/screens/register_screen.dart';

// Screens
import 'package:pontevecchio/screens/screens.dart';

class Routes {
  static const initialRoute = 'login';

  static final viewOptions = <ViewOptions>[
    ViewOptions(
      route: '/login_screen',
      name: 'login',
      screen: const LoginScreen(),
    ),
    ViewOptions(
      route: '/table_list_screen',
      name: 'tables',
      screen: const TablesScreen(),
    ),
    ViewOptions(
      route: '/register_screen',
      name: 'register',
      screen: const RegisterScreen(),
    ),
    ViewOptions(
        route: '/successful_payment',
        name: 'successful_payment',
        screen: const SuccessfulPayment()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});

    for (final option in viewOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
