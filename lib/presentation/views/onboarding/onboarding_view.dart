import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import 'package:base_flutter/domain/models/onboarding_model.dart';
import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/routes_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:base_flutter/presentation/widgets/button/button_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final AppPreferences _appPreferences = dIinstance<AppPreferences>();
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController();
    _appPreferences.onboardingViewd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            ImageAssets.bgBubble5,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() {
                  _currentPage = value;
                }),
                itemCount: dummyOnboardingList.length,
                itemBuilder: (context, index) => _buildOnboardingItem(index),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(dummyOnboardingList.length,
                  (int index) => _buildDots(index: index)),
            ),
            const SizedBox(
              height: 54,
            )
          ],
        )
      ]),
    );
  }

  Widget _buildOnboardingItem(int index) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: ColorManager.white,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                dummyOnboardingList[index].image,
                height: 338,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 46,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: Column(
                  children: [
                    Text(
                      dummyOnboardingList[index].title,
                      textAlign: TextAlign.center,
                      style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 28,
                          fontFamily: FontFamily.raleway),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      dummyOnboardingList[index].description,
                      textAlign: TextAlign.center,
                      style: getLightStyle(
                          color: ColorManager.black,
                          fontSize: 19,
                          fontFamily: FontFamily.nunitoSans),
                    ),
                    index == 3
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              ButtonComponent(
                                  title: 'Let\'s Start',
                                  isFullWidth: false,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, Routes.loginRoute);
                                  })
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color:
              _currentPage == index ? ColorManager.blue1 : ColorManager.blue3),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      curve: Curves.easeIn,
      width: 20,
    );
  }
}
