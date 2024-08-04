import 'package:base_project_mvvm_provider/data/response/api_response.dart';
import 'package:base_project_mvvm_provider/models/user_model.dart';
import 'package:base_project_mvvm_provider/base/base_view_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:base_project_mvvm_provider/repository/auth_repository.dart';
import 'package:base_project_mvvm_provider/utils/routes/routes_names.dart';
import 'package:base_project_mvvm_provider/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends BaseModel {
  final AuthRepository authRepo = AuthRepository();

  ApiResponse<UserModel> user = ApiResponse.idle();

  void setUser(ApiResponse<UserModel> response) async {
    user = response;
    notifyListeners();
  }

  Future<void> apilogin(dynamic data, BuildContext context) async {
    setUser(ApiResponse.loading());
    authRepo.login(data).then((value) {
      setUser(ApiResponse.completed(value));

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(value);

      flushBarErrorMessage("Login Successfull", context);

      Navigator.pushNamed(context, RouteNames.home);
    }).onError((error, stackTrace) {
      flushBarErrorMessage(error.toString(), context);
      setUser(ApiResponse.error(error.toString()));
    });
  }
}
