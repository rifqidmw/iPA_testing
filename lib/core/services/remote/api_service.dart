import 'package:dio/dio.dart';
import 'package:base_flutter/core/constants/constants.dart';
import 'package:base_flutter/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';
//run in terminal "dart pub run build_runner build" in every change

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiServiceClient{
  factory ApiServiceClient(Dio dio,{String baseUrl})= _ApiServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(@Field("email") String email,@Field("password") String password);
  
  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
  
  @POST("/customers/register")
  Future<AuthenticationResponse> register(@Field("user_name") String userName,
                                          @Field("country_mobile_code") String countryMobileCode,
                                          @Field("mobile_number") String mobileNumber,
                                          @Field("email") String email,
                                          @Field("password") String password,
                                          @Field("profile_picture") String profilePicture,
                                          );
  
  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/store")
  Future<StoreDetailsResponse> getStoreDetailsData();
}