import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/data/responses/product/product_response.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:base_flutter/presentation/resources/constants_manager.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';
//run in terminal "dart run build_runner build --delete-conflicting-outputs" in every change

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @POST(ApiEndpoints.loginEndpoint)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET(ApiEndpoints.productEndpoint)
  Future<ProductResponse> getProducts();
}
