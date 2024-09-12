import 'package:base_flutter/core/services/remote/api_service.dart';
import 'package:base_flutter/data/responses/responses.dart';
import 'package:base_flutter/domain/requests.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetailsData();

}

class RemoteDataSourceImp implements RemoteDataSource {

  final ApiServiceClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
   return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email)async {
    return await _appServicesClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest)async {
   return await _appServicesClient.register(registerRequest.userName, registerRequest.countryMobileCode, registerRequest.mobileNumber,
    registerRequest.email, registerRequest.password, registerRequest.profilePicture);
  }
  
  @override
  Future<HomeResponse> getHomeData()async {
    return await _appServicesClient.getHomeData();
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetailsData()async {
    return await _appServicesClient.getStoreDetailsData();
  }
}