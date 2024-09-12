import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/models/models.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository ;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.getHomeData();
  }
}
