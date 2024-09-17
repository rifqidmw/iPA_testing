import 'package:base_flutter/domain/models/product_model.dart';
import 'package:base_flutter/domain/models/user_model.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';

abstract class Repository {
  Future<Either<Failure, UserModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, List<ProductModel>>> getProducts();
}
