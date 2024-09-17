import 'package:base_flutter/data/mapper/mapper.dart';
import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/data/responses/product/product_response.dart';
import 'package:base_flutter/domain/models/product_model.dart';
import 'package:base_flutter/domain/models/user_model.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/error-handler.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'package:base_flutter/data/data_source/local_data_sourece.dart';
import 'package:base_flutter/data/data_source/remote_data_source.dart';
import 'package:base_flutter/core/services/remote/network_info.dart';

class RepositoryImp implements Repository {
  late final RemoteDataSource _remoteDataSource;
  late final NetworkInfo _networkInfo;
  late final LocalDataSource _localDataSource;

  RepositoryImp(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, UserModel>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final LoginResponse response =
            await _remoteDataSource.login(loginRequest);
        if (response.token != null) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.token ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    if (await _networkInfo.isConnected) {
      try {
        final ProductResponse response = await _remoteDataSource.getProducts();
        if (response.products?.isNotEmpty ?? true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.FAILURE, ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
