import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>>  execute(In input);
}