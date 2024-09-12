import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'package:base_flutter/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String,String>{
  ForgotPasswordUseCase(this.repository);
  Repository repository;
  @override
  Future<Either<Failure, String>> execute(String input)async {
    return await repository.forgotPassword(input);
  }
}