import 'package:base_project_mvvm_provider/utils/utils.dart';
import 'package:base_project_mvvm_provider/utils/models/language_data_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/constants.dart';
import 'package:base_project_mvvm_provider/utils/utils/shared_pref.dart';
import 'package:base_project_mvvm_provider/utils/utils/size_config.dart';
import 'package:base_project_mvvm_provider/utils/utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:base_project_mvvm_provider/utils/routes/routes.dart';
import 'package:base_project_mvvm_provider/utils/routes/routes_names.dart';
import 'package:base_project_mvvm_provider/viewModel/auth_view_model.dart';
import 'package:base_project_mvvm_provider/viewModel/home_view_model.dart';
import 'package:base_project_mvvm_provider/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

const APP_NAME = 'Base Project';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: [
    LanguageDataModel(name: 'English', languageCode: 'en'),
    LanguageDataModel(name: 'Indonesia', languageCode: 'in'),
  ]);

  defaultToastBackgroundColor = Colors.black;
  defaultToastTextColor = Colors.white;
  defaultToastGravityGlobal = ToastGravity.CENTER;
  defaultRadius = 16;
  defaultAppButtonRadius = 16;

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder<ThemeData>(
      future: getMaterialYouTheme(),
      builder: (_, snap) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<UserViewModel>(
              create: (context) => UserViewModel(),
            ),
            ChangeNotifierProvider<AuthViewModel>(
                create: (context) => AuthViewModel()),
            ChangeNotifierProvider<HomeViewModel>(
              create: (context) => HomeViewModel(),
            )
          ],
          builder: (ctx, wdgt) => MaterialApp(
            title: APP_NAME,
            theme: snap.data ??
                ThemeData.light(
                  useMaterial3: true,
                ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ),
            themeMode: getIntAsync(THEME_MODE_INDEX) == 2
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: RouteNames.splashScreen,
            onGenerateRoute: Routes.generateRoutes,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
