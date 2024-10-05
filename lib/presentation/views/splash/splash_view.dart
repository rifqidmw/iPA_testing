import 'dart:async';

import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        _appPreferences.isOnboardingViewd().then((isOnboardingViewd) {
          if (isOnboardingViewd!) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: ColorManager.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 21),
                child: SvgPicture.asset(
                  ImageAssets.logoSplash,
                  height: 92,
                  width: 92,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Shoppe',
              textAlign: TextAlign.center,
              style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: 52,
                  fontFamily: FontFamily.raleway),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Beautiful eCommerce UI Kit for your online store',
              textAlign: TextAlign.center,
              style: getLightStyle(
                  color: ColorManager.black,
                  fontSize: 19,
                  fontFamily: FontFamily.nunitoSans),
            ),
          ],
        ),
      ),
    );
  }
}
