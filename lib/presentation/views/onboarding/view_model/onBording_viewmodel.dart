import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../../../domain/models/models.dart';
import '../../../../core/base/base_viewmodel.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel implements OnBoardingViewModelInputs , OnBoardingViewModelOutputs {

  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list ;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }
  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private methods
  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1.tr(),
        AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onboardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2.tr(),
        AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onboardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3.tr(),
        AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onboardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4.tr(),
        AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onboardingLogo4),
  ];

  void _postDataToView() {
    _streamController.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}



// inputs mean that "Orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left
  void goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);
  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  // stream controller output
  Stream get outputSliderViewObject;
}