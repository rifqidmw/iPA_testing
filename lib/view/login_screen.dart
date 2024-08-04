import 'package:base_project_mvvm_provider/data/response/status.dart';
import 'package:base_project_mvvm_provider/res/widgets/button_with_loader.dart';
import 'package:base_project_mvvm_provider/utils/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:base_project_mvvm_provider/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthViewModel authViewModel = AuthViewModel();
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    _emailController.text = 'emilys';
    _passwordController.text = 'emilyspass';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ChangeNotifierProvider<AuthViewModel>(
        create: (context) => authViewModel,
        child: Consumer<AuthViewModel>(
          builder: (context, value, child) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {
                        changeNodeFocus(context,
                            current: _emailFocus, next: _passwordFocus);
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        label: const Text("Email"),
                        hintText: "tes.dev@gmail.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder(
                      valueListenable: _obsecureNotifier,
                      builder: ((context, value, child) {
                        return TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: _obsecureNotifier.value,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: _obsecureNotifier.value
                                ? InkWell(
                                    onTap: () {
                                      _obsecureNotifier.value =
                                          !_obsecureNotifier.value;
                                    },
                                    child: const Icon(Icons.visibility),
                                  )
                                : InkWell(
                                    onTap: () {
                                      _obsecureNotifier.value =
                                          !_obsecureNotifier.value;
                                    },
                                    child: const Icon(Icons.visibility_off),
                                  ),
                            label: const Text("Password"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  ButtonWithLoader(
                      title: "Login",
                      loading: value.user.status == Status.loading,
                      onPress: () {
                        if (_emailController.text.isEmpty &&
                            _passwordController.text.isEmpty) {
                          flushBarErrorMessage(
                              "Email atau Password salah!", context);
                        } else if (_passwordController.text.isEmpty) {
                          flushBarErrorMessage(
                              "Password harus diisi!", context);
                        } else if (_emailController.text.isEmpty) {
                          flushBarErrorMessage(
                              "Email harus diisi!", context);
                        } else {
                          dynamic data = {
                            "username": _emailController.text.toString(),
                            "password": _passwordController.text.toString()
                          };
                          authViewModel.apilogin(data, context);
                        }
                      }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Text("Don't have an account yet? Sign Up!"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}
