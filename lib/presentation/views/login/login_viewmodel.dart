import 'dart:async';
import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:base_flutter/core/services/local/app_prefs.dart';
import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/core/base/base_viewmodel.dart';
import 'package:base_flutter/presentation/widgets/state_renderer/state_renderer_imp.dart';
import 'package:base_flutter/presentation/widgets/state_renderer/state_rendrer.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import '../../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  var loginRequest = LoginRequest();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoggedinSuccessfullyStreamController =
      StreamController<bool>();

  final AppPreferences _appPreferences = dIinstance<AppPreferences>();

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _emailStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    stateInput.add(ContentState());
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginRequest.password = password;
    inputAreAllInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginRequest.username = email;
    inputAreAllInputsValid.add(null);
  }

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _isValid(String? val) {
    return val?.isNotEmpty ?? true;
  }

  bool _areAllInputsValid() {
    return _isValid(loginRequest.password) && _isValid(loginRequest.username);
  }

  @override
  Stream<bool> get isPasswordValid =>
      _passwordStreamController.stream.map((password) => _isValid(password));

  @override
  Stream<bool> get isUserNameValid =>
      _emailStreamController.stream.map((userName) => _isValid(userName));

  @override
  login() async {
    stateInput.add(LoadingState(
        stateType: RendrerStateType.popupLoadingState,
        message: getString(AppStrings.loadingMessage),
        title: getString(AppStrings.loading)));

    (await _loginUseCase.execute(LoginUseCaseInput(loginRequest))).fold(
        (failure) {
      stateInput.add(ErrorState(
        stateRendererType: RendrerStateType.popupErorrState,
        message: failure.message,
      ));
    }, (data) {
      isUserLoggedinSuccessfullyStreamController.add(true);
      stateInput.add(ContentState());
      _appPreferences.userLoggedIn();
    });
  }
}

abstract class LoginViewModelInput {
  login();

  setEmail(String userName);

  setPassword(String password);

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get isUserNameValid;

  Stream<bool> get isPasswordValid;

  Stream<bool> get outAreAllInputsValid;
}
