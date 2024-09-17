import 'package:base_flutter/domain/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import '../../core/base/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, void> {
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, List<ProductModel>>> execute(void input) async {
    return await _repository.getProducts();
  }
}
