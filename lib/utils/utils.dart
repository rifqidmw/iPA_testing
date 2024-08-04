import 'dart:async';

import 'package:base_project_mvvm_provider/utils/extensions/int_extensions.dart';
import 'package:base_project_mvvm_provider/utils/models/language_data_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/colors.dart';
import 'package:base_project_mvvm_provider/utils/utils/common.dart';
import 'package:base_project_mvvm_provider/utils/utils/constants.dart';
import 'package:base_project_mvvm_provider/utils/utils/decorations.dart';
import 'package:base_project_mvvm_provider/utils/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:shared_preferences/shared_preferences.dart';

//region Global variables - This variables can be changed.
Color textPrimaryColorGlobal = textPrimaryColor;
Color textSecondaryColorGlobal = textSecondaryColor;
double textBoldSizeGlobal = 16;
double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
String? fontFamilyBoldGlobal;
String? fontFamilyPrimaryGlobal;
String? fontFamilySecondaryGlobal;
FontWeight fontWeightBoldGlobal = FontWeight.bold;
FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

Color appBarBackgroundColorGlobal = Colors.white;
Color appButtonBackgroundColorGlobal = Colors.white;
Color defaultAppButtonTextColorGlobal = textPrimaryColorGlobal;
double defaultAppButtonRadius = 8.0;
double defaultAppButtonElevation = 4.0;
bool enableAppButtonScaleAnimationGlobal = true;
int? appButtonScaleAnimationDurationGlobal;
ShapeBorder? defaultAppButtonShapeBorder;

Color defaultLoaderBgColorGlobal = Colors.white;
Color? defaultLoaderAccentColorGlobal;

Color? defaultInkWellSplashColor;
Color? defaultInkWellHoverColor;
Color? defaultInkWellHighlightColor;
double? defaultInkWellRadius;

Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
int defaultElevation = 4;
double defaultRadius = 8.0;
double defaultBlurRadius = 4.0;
double defaultSpreadRadius = 1.0;
double defaultAppBarElevation = 4.0;

double? maxScreenWidth;

double tabletBreakpointGlobal = 600.0;
double desktopBreakpointGlobal = 720.0;

int passwordLengthGlobal = 6;

ShapeBorder? defaultDialogShape;

String defaultCurrencySymbol = currencyRupiah;

LanguageDataModel? selectedLanguageDataModel;
List<LanguageDataModel> localeLanguageList = [];

/// If forceEnableDebug if true, you will be able to see log in the logcat in release build also.
/// By default, your log will not seen in logcat in release mode.
bool forceEnableDebug = false;

// Toast Config
Color defaultToastBackgroundColor = Colors.grey.shade200;
Color defaultToastTextColor = Colors.black;
ToastGravity defaultToastGravityGlobal = ToastGravity.CENTER;
BorderRadius defaultToastBorderRadiusGlobal = radius(30);

PageRouteAnimation? pageRouteAnimationGlobal;
Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

//ChatGpt Key
String chatGPTAPIkey = '';
ChatGPTConfig chatGPTConfigGlobal = ChatGPTConfig();

//endregion

const channelName = 'nb_utils';
final navigatorKey = GlobalKey<NavigatorState>();

get getContext => navigatorKey.currentState?.overlay?.context;

// Must be initialize before using shared preference
Future<void> initialize({
  double? defaultDialogBorderRadius,
  List<LanguageDataModel>? aLocaleLanguageList,
  String? defaultLanguage,
}) async {
  sharedPreferences = await SharedPreferences.getInstance();

  defaultAppButtonShapeBorder =
      RoundedRectangleBorder(borderRadius: radius(defaultAppButtonRadius));

  defaultDialogShape = dialogShape(defaultDialogBorderRadius);

  localeLanguageList = aLocaleLanguageList ?? [];

  selectedLanguageDataModel =
      getSelectedLanguageModel(defaultLanguage: defaultLanguage);
}

/// nb_utils class
class NBUtils {
  static const MethodChannel _channel = MethodChannel(channelName);

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

/// Redirect to given widget without context
Future<T?> push<T>(
  Widget widget, {
  bool isNewTask = false,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
}) async {
  if (isNewTask) {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      buildPageRoute(
          widget, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
      (route) => false,
    );
  } else {
    return await Navigator.of(getContext).push(
      buildPageRoute(
          widget, pageRouteAnimation ?? pageRouteAnimationGlobal, duration),
    );
  }
}

/// Dispose current screen or close current dialog
void pop([Object? object]) {
  if (Navigator.canPop(getContext)) Navigator.pop(getContext, object);
}
