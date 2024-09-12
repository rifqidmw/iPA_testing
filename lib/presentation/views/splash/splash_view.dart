import 'dart:async';

import 'package:flutter/material.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import '../../../core/di/dependency_injection.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = dIinstance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {

    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn!) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      _appPreferences.isOnboardingViewd().then((isOnboardingViewd) {
        if (isOnboardingViewd!) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      }
      });
    }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    //here u can prevent any memory leak!
    _timer?.cancel();
    super.dispose();
  }
}
