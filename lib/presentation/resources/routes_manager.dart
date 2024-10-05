import 'package:base_flutter/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';


class Routes {
  static const String splashRoute = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(getString(AppStrings.noRouteFound)),
              ),
              body: Center(child: Text(getString(AppStrings.noRouteFound))),
            ));
  }
}
