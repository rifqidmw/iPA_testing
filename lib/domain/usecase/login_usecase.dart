import 'package:base_flutter/domain/models/user_model.dart';
import 'package:base_flutter/domain/request/login/login_request.dart';
import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import '../../core/base/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, UserModel> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> execute(LoginUseCaseInput input) async {
    return await _repository.login(input.loginRequest);
  }
}

class LoginUseCaseInput {
  LoginRequest loginRequest;
  LoginUseCaseInput(this.loginRequest);
}
