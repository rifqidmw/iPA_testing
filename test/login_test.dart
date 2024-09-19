import 'package:base_flutter/core/services/remote/api_service.dart';
import 'package:base_flutter/data/data_source/remote_data_source.dart';
import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';


void main() {
  final getIt = GetIt.instance;
  late RemoteDataSource remoteDataSource;
  late ApiServiceClient apiServiceClient;

  setUp(() {
    Dio dio = Dio();
    getIt.reset();

    apiServiceClient = ApiServiceClient(dio);
    getIt.registerLazySingleton<ApiServiceClient>(() => apiServiceClient);

    remoteDataSource = RemoteDataSourceImp(getIt<ApiServiceClient>());
  });

  test('should return UserResponse when login is successful', () async {
    // Arrange
    final loginRequest = LoginRequest(
        username: '1', password: '2', expiresInMins: 60);

    final expectedResponse = LoginResponse(
        id: 1,
        username: 'emilys',
        email: 'emily.johnson@x.dummyjson.com',
        firstName: 'Emily',
        lastName: 'Johnson',
        gender: 'female',
        image: 'https://dummyjson.com/icon/emilys/128',
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjY2NTE2ODUsImV4cCI6MTcyNjY1NTI4NX0.f03SSbNY5VhTgiKL8x-fwc51wApVhYJb64nOg9SB37k',
        refreshToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjY2NTExNTMsImV4cCI6MTcyOTI0MzE1M30.6y9klhQAo5V5ELR5MsFHXWrRowcT7kNtyA_TI6E7dvs');

    try {
      final result = await remoteDataSource.login(loginRequest);
      expect(result.id, 1);
    } on DioException catch (e) {
      fail('Expected a Dio Exception: $e');
    } catch (e) {
      fail('Expected a error but got a different exception: $e');
    }    
  });

  test('should throw an exception if login fails', () async {
    final loginRequest = LoginRequest(
        username: 'emilys', password: 'emilyspass', expiresInMins: 60);

    try {
      await remoteDataSource.login(loginRequest);
      fail('Expected a error with status code 400 but got a success.');
    } on DioException catch (e) {
      expect(e.response?.statusCode, equals(400));
    } catch (e) {
      fail('Expected a error but got a different exception: $e');
    }
  });
}
