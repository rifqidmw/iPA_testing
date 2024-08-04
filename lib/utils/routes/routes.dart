import 'package:flutter/material.dart';
import 'package:base_project_mvvm_provider/utils/routes/routes_names.dart';
import 'package:base_project_mvvm_provider/view/home_screen.dart';
import 'package:base_project_mvvm_provider/view/login_screen.dart';
import 'package:base_project_mvvm_provider/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    // final args = (settings.arguments ?? <String, dynamic>{}) as Map;

    switch (settings.name) {
      case (RouteNames.home):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case (RouteNames.login):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
