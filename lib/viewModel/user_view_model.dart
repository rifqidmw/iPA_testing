import 'package:base_project_mvvm_provider/data/network/api_endpoints.dart';
import 'package:base_project_mvvm_provider/base/base_view_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/shared_pref.dart';
import 'package:base_project_mvvm_provider/models/user_model.dart';

class UserViewModel extends BaseModel {
  Future<bool> saveUser(UserModel user) async {
    user.tokenMovie = ApiEndpoints.moviesToken;
    setValue('users', userModelToJson(user));

    return true;
  }

  Future<bool> removeUser() async {
    removeKey("users");
    return true;
  }

  Future<UserModel?> getUser() async {
    var users = getStringAsync('users');

    if (users != '') {
      final UserModel? userModel = userModelFromJson(users);
      return userModel;
    } else {
      return null;
    }

  }
}
