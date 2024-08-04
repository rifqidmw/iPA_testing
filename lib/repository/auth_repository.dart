import 'package:base_project_mvvm_provider/data/network/api_services.dart';
import 'package:base_project_mvvm_provider/models/user_model.dart';
import 'package:base_project_mvvm_provider/data/network/api_endpoints.dart';

class AuthRepository {
  final ApiServices apiServices = ApiServices();

  Future<UserModel> login(dynamic data) async {
    try {
      dynamic response =
          await apiServices.getPostApiResponse(ApiEndpoints.loginEndPoint, data);

      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUp(dynamic data) async {
    try {
      final response =
          await apiServices.getPostApiResponse(ApiEndpoints.registerEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
