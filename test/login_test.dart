import 'package:base_flutter/core/services/remote/api_service.dart';
import 'package:base_flutter/data/data_source/remote_data_source.dart';
import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'remote_data_source_test.mocks.dart';

void main() {
  final getIt = GetIt.instance;
  late RemoteDataSource remoteDataSource;
  late MockApiServiceClient mockApiServiceClient;

  setUp(() {
    getIt.reset();

    mockApiServiceClient = MockApiServiceClient();
    getIt.registerLazySingleton<ApiServiceClient>(() => mockApiServiceClient);

    remoteDataSource = RemoteDataSourceImp(getIt<ApiServiceClient>());
  });

  test('should return UserResponse when login is successful', () async {
    // Arrange
    final loginRequest = LoginRequest(
        username: 'emilys', password: 'emilyspass', expiresInMins: 60);
    final userResponse = LoginResponse(
        id: 1,
        username: 'emilys',
        email: 'emily.johnson@x.dummyjson.com',
        firstName: 'Emily',
        lastName: 'Johnson',
        gender: 'female',
        image: 'https://dummyjson.com/icon/emilys/128',
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjY1NDg5MjUsImV4cCI6MTcyNjU1MjUyNX0.dwkrwrD6LI2d3gdh-FRGxye9o_0TumCFDhxBfEyF2lY',
        refreshToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MjY1NDg5MjUsImV4cCI6MTcyOTE0MDkyNX0.rPhhTNzIB5bSiPu2ItN9azoqkImN-zNJFTb9YrX9q7Y');

    when(remoteDataSource.login(loginRequest))
        .thenAnswer((_) async => userResponse);

    final result = await remoteDataSource.login(loginRequest);

    expect(result, userResponse);
  });

  test('should throw an exception if login fails', () async {
    final loginRequest = LoginRequest(
        username: 'user', password: 'pass', expiresInMins: 60);

    when(mockApiServiceClient.login(loginRequest))
        .thenAnswer((_) async => throw Exception('Login failed'));

    expect(() => remoteDataSource.login(loginRequest), throwsException);

    verify(mockApiServiceClient.login(loginRequest)).called(1);
  });
}
