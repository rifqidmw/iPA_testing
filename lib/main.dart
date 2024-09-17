import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/core/app.dart';
import 'package:base_flutter/presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [englishLocal, indonesiaLocal],
      path: localisationsPath,
      child: Phoenix(child: MyApp())));
}
