import 'package:base_project_mvvm_provider/utils/routes/routes_names.dart';
import 'package:base_project_mvvm_provider/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();

    userViewModel = Provider.of<UserViewModel>(context, listen: false);

    checkUserStatus();
  }

  @override
  void dispose() {
    userViewModel.dispose();
    super.dispose();
  }

  void checkUserStatus() async {
    final user = await userViewModel.getUser();

    if (user == null) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.login);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Splash Screen",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
