import 'package:base_flutter/core/services/remote/api_service.dart';
import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/data/responses/product/product_response.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<ProductResponse> getProducts();
}

class RemoteDataSourceImp implements RemoteDataSource {
  final ApiServiceClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(loginRequest);
  }
  
  @override
  Future<ProductResponse> getProducts() async {
    return await _appServicesClient.getProducts();
  }
}
