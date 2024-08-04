import 'package:base_project_mvvm_provider/utils/utils.dart';
import 'package:base_project_mvvm_provider/utils/extensions/string_extensions.dart';
import 'package:base_project_mvvm_provider/utils/utils/constants.dart';
import 'package:base_project_mvvm_provider/utils/utils/shared_pref.dart';
import 'package:flutter/material.dart';

/// Model class for Locales
class LanguageDataModel {
  int? id;
  String? name;
  String? languageCode;
  String? fullLanguageCode;
  String? flag;
  String? subTitle;

  LanguageDataModel({
    this.id,
    this.name,
    this.languageCode,
    this.flag,
    this.fullLanguageCode,
    this.subTitle,
  });

  static List<String> languages() {
    List<String> list = [];

    for (var element in localeLanguageList) {
      list.add(element.languageCode.validate());
    }

    return list;
  }

  static List<Locale> languageLocales() {
    List<Locale> list = [];

    for (var element in localeLanguageList) {
      list.add(Locale(element.languageCode.validate(),
          element.fullLanguageCode.validate()));
    }

    return list;
  }
}

LanguageDataModel? getSelectedLanguageModel({String? defaultLanguage}) {
  LanguageDataModel? data;

  for (var element in localeLanguageList) {
    if (element.languageCode ==
        getStringAsync(SELECTED_LANGUAGE_CODE,
            defaultValue: defaultLanguage ?? 'en')) {
      data = element;
    }
  }

  return data;
}
