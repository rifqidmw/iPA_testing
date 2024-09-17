import 'package:flutter/rendering.dart';

enum LanguageType { english, indonesia }

const String english = "en";
const String indonesia = "in";

const Locale englishLocal = Locale("en", "US");
const Locale indonesiaLocal = Locale("id", "ID");

const String localisationsPath = "assets/translations";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.indonesia:
        return indonesia;
    }
  }
}
