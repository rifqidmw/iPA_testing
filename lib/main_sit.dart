import 'package:base_flutter/core/app.dart';
import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/core/env.dart';
import 'package:base_flutter/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async{
  AppEnvironment.setupEnv(Environment.sit);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp( EasyLocalization(supportedLocales: const [indonesiaLocal,englishLocal], path: localisationsPath, child: Phoenix(child: MyApp())));
}