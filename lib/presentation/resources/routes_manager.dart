import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/presentation/views/home/home_view.dart';
import 'package:base_flutter/presentation/views/setting/setting_view.dart';
import 'package:base_flutter/presentation/views/onboarding/onboarding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';

import '../../core/di/dependency_injection.dart';
import '../views/login/login_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String settingRoute = "/setting";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.homeRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.settingRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const SettingView());
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
