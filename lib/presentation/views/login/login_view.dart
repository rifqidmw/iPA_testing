import 'package:base_flutter/core/utils/functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/presentation/widgets/state_renderer/state_renderer_imp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/button/button_component.dart';
import '../../widgets/text_field/text_field_component.dart';
import 'login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = dIinstance<LoginViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController
        .addListener(() => _viewModel.setEmail(_usernameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedinSuccessfullyStreamController.stream
        .listen((isLogged) {
      if (isLogged) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOutput,
        builder: (context, snapshot) =>
            snapshot.data
                ?.getScreenWidget(context, _getContentWidget(), () {}) ??
            _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: SvgPicture.asset(
            ImageAssets.bgBubble2,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          children: [
            const Spacer(),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getString(AppStrings.login),
                          style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s52),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getString(AppStrings.loginDescription),
                              style: getLightStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s19),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.favorite,
                              color: ColorManager.black,
                              size: 16,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder(
                          stream: _viewModel.isUserNameValid,
                          builder: (context, snapshot) {
                            return TextFieldComponent(
                              hintText: getString(AppStrings.username),
                              inputType: TextInputType.name,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : getString(AppStrings.usernameError),
                              controller: _usernameController,
                              onChanged: (value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder(
                          stream: _viewModel.isPasswordValid,
                          builder: (context, snapshot) {
                            return TextFieldComponent(
                              hintText: getString(AppStrings.password),
                              inputType: TextInputType.visiblePassword,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : getString(AppStrings.passwordError),
                              inputAction: TextInputAction.done,
                              controller: _passwordController,
                              onChanged: (value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        StreamBuilder(
                          stream: _viewModel.outAreAllInputsValid,
                          builder: (context, snapshot) {
                            return ButtonComponent(
                                title: getString(AppStrings.login),
                                onPressed: () {
                                  if (snapshot.data ?? false) {
                                    _viewModel.login();
                                  }
                                });
                          },
                        ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
