import 'package:dartz/dartz.dart';
import 'package:base_flutter/core/services/remote/failure.dart';
import 'package:base_flutter/domain/models/models.dart';
import 'package:base_flutter/domain/repository/repository.dart';
import 'package:base_flutter/domain/requests.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{
  final Repository _repository ;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequest(input.email,input.password));
  }
}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}