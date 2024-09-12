import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/models/models.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUSeCase implements BaseUseCase<void,StoreDetails>{
  final Repository _repository ;
  StoreDetailsUSeCase(this._repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async{
    return await _repository.getStoreDetailsData();
  }
}
