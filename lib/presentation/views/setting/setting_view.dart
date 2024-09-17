import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/data/data_source/local_data_sourece.dart';
import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import 'package:base_flutter/presentation/resources/values_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final AppPreferences _sharedPreferences = dIinstance<AppPreferences>();
  final LocalDataSource _localDataSource = dIinstance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getString(AppStrings.settings),
          style: getSemiBoldStyle(color: ColorManager.black, fontSize: 20),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
      ),
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.icChangeLanguage,
                colorFilter: const ColorFilter.mode(
                    ColorManager.darkPrimary, BlendMode.srcIn)),
            title: Text(
              getString(AppStrings.changeLang),
            ),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(0),
              child: SvgPicture.asset(ImageAssets.icArrowRight,
                  colorFilter: const ColorFilter.mode(
                      ColorManager.darkPrimary, BlendMode.srcIn)),
            ),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.icLogout,
                colorFilter: const ColorFilter.mode(
                    ColorManager.darkPrimary, BlendMode.srcIn)),
            title: Text(getString(AppStrings.logout)),
            trailing: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(0),
              child: SvgPicture.asset(ImageAssets.icArrowRight,
                  colorFilter: const ColorFilter.mode(
                      ColorManager.darkPrimary, BlendMode.srcIn)),
            ),
            onTap: () async {
              await _logout();
            },
          )
        ]),
      ),
    );
  }

  _changeLanguage() {
    _sharedPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  _contactUS() {}

  _inviteFriends() {}

  Future<void> _logout() async {
    _localDataSource.clearCache();
    await _sharedPreferences.logout();
    Navigator.of(context).pushNamed(Routes.loginRoute);
  }
}
